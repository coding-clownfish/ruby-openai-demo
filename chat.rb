# Write your solution here!

require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))


# Set up an Array of message list with a system message
message_list = [
  {
    "role" => "system",
    "content" => "You are a crazy assistant."
  }
]

#Start a conversation loop
user_input = ""

while user_input != "bye"
puts "Hello! How can I help you today?"
puts "-" * 50

#Get user input
user_input = gets.chomp

#Add user message to the message_list
  if user_input != "bye"
  message_list.push ({"role" => "system", "content" => user_input})
  

  #Call the API response to get the next message from GPT
  api_response = client.chat(
    parameters:{
      model: "gpt-3.5-turbo",
      messages: message_list
    }
  )
  #Dig through JSON response to get the content
  choices = api_response.fetch("choices")
  first_choice = choices.at(0)
  message = first_choice.fetch("message")
  assistant_response = message["content"]

  # Print the assistant's response
    puts assistant_response
    puts "-" * 50

  # Add the assistant's response to the message list
  message_list.push({"role"=>"system","content"=>assistant_response})
  end
end
