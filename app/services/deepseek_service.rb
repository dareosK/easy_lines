require 'deepseek'

class DeepseekService
  def initialize
    @client = Deepseek::Client.new(
      api_key: ENV.fetch('DEEPSEEK_API_KEY'),
      timeout: 60,
      max_retries: 3
    )
  end

  def chat(prompt, model: 'deepseek-chat')
    response = @client.chat(
      messages: [{ role: 'user', content: prompt }],
      model: model
    )

    response.dig('choices', 0, 'message', 'content')
    puts response
  rescue StandardError => e
    Rails.logger.error "Deepseek API Error: #{e.message}"
    nil
  end
end


# THIS SEEMS TO BE WORKING
# require 'net/http'
# require 'uri'
# require 'json'

# class DeepseekService
#   def initialize
#     @api_key = ENV.fetch('DEEPSEEK_API_KEY')
#     @uri = URI("https://api.deepseek.com/chat/completions")
#   end

#   def chat(prompt, model: 'deepseek-chat')
#     # Prepare the request payload
#     request_body = {
#       model: model,
#       messages: [
#         { role: 'system', content: "You are a helpful assistant." },
#         { role: 'user', content: prompt }
#       ],
#       stream: false
#     }.to_json

#     # Make the HTTP request
#     response = make_request(request_body)
#     parse_response(response)
#   rescue StandardError => e
#     Rails.logger.error "Deepseek API Error: #{e.message}"
#     nil
#   end

#   private

#   def make_request(request_body)
#     http = Net::HTTP.new(@uri.host, @uri.port)
#     http.use_ssl = true

#     request = Net::HTTP::Post.new(@uri)
#     request["Content-Type"] = "application/json"
#     request["Authorization"] = "Bearer #{@api_key}"
#     request.body = request_body

#     # Send the request
#     http.request(request)
#   end

#   def parse_response(response)
#     # Parse the response body to JSON and extract the result
#     puts parsed_response = JSON.parse(response.body)
#     parsed_response.dig('choices', 0, 'message', 'content')
#   end
# end
