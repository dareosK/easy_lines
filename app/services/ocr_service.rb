class OcrService
  include HTTParty
  base_uri 'https://api.deepseek.com' #  is that the endpoint?

  def initialize(api_key)
    @api_key = api_key
  end

  def extract_text(image_url)
    body = {
      image: image_url,
      options: {
        language: 'eng',
        detect_handwriting: false # maybe later?
      }
    }.to_json

    response = self.class.post('/ocr', body: body, headers: { 'Authorization' => "Bearer #{@api_key}", 'Content-Type' => 'application/json' })
    response.parsed_response['text'] # check the structure of the endpoint first
  end
end
