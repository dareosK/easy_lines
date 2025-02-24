require 'openai'

class OpenAiService
  def initialize
    @client = OpenAI::Client.new(access_token: ENV['OPENAI_API_ACCESS_KEY'])
  end

  def extract_text_from_image(image_url)
    puts "💪🏻 inside the Service"
    p "👉 the client: #{@client}"
    response = @client.images.generate(
      parameters: {
        model: "gpt-4-vision-preview",
        messages: [
          {
            role: "system",
            content: "You are an AI that extracts structured script text from images."
          },
          {
            role: "user",
            content: [
              { type: "text", text: "Extract dialogue from this script image in structured JSON format." },
              { type: "image_url", image_url: image_url }
            ]
          }
        ],
        max_tokens: 1000
      }
    )
    puts "response:"
    puts response
    JSON.parse(response["choices"][0]["message"]["content"])
  end
end
