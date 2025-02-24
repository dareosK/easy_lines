require 'open-uri'
require 'rtesseract'

class ProcessScriptImageJob < ApplicationJob
  queue_as :default

  def perform(piece_image_id)
    puts "✅✅✅✅✅✅✅ INTO THE JOB"
    piece_image = PieceImage.find(piece_image_id)
    puts "🌟 PieceImage found"
    image_url = Rails.application.routes.url_helpers.url_for(piece_image.image.file)

    puts "🌟 Downloading image and performing OCR"
    ocr_text = extract_text_from_image(image_url)

    puts "🌟 Processing text"
    process_extracted_script(ocr_text, piece_image)
  end

  private

  def extract_text_from_image(image_url)
    begin
      # Open the image URL and download it as a Tempfile
      image = URI.open(image_url)

      # Save it to a temporary file on the system
      tempfile_path = image.path
      puts "Image Path: #{tempfile_path}"
      puts "🌟 Image downloaded successfully"

      # Use RTesseract with the tempfile path (not the Tempfile object itself)
      ocr_result = RTesseract.new(tempfile_path).to_s
      puts "OCR Result: #{ocr_result}"
      parse_ocr_result(ocr_result)
    rescue OpenURI::HTTPError => e
      puts "🚨 Error downloading image: #{e.message}"
      return nil
    rescue Timeout::Error => e
      puts "🚨 Timeout error: #{e.message}"
      return nil
    rescue StandardError => e
      puts "🚨 Unexpected error: #{e.message}"
      return nil
    end
  end


  def parse_ocr_result(ocr_result)
    puts "Assuming the OCR result is in a format like 'Character: Line of dialogue'"
    script_data = {"lines" => []}

    puts "creating characters"
    previous_character = nil
    previous_text = nil

    ocr_result.each_line.with_index do |line, index|
      line.strip!

      # Skip empty lines
      next if line.empty?

      # Split the line by the first colon
      character, text = line.split(":", 2)

      if text.nil?
        # If no colon is found, this is part of the previous character's dialogue
        if previous_character
          previous_text += " " + line.strip
          script_data["lines"].last["text"] = previous_text
          next
        else
          # If there's no previous character, skip this line (malformed or unexpected case)
          next
        end
      else
        # A new character is found
        previous_character = character.strip
        previous_text = text.strip

        script_data["lines"] << {
          "character" => previous_character,
          "text" => previous_text,
          "order" => index + 1
        }
      end
    end

    script_data
  end

  def process_extracted_script(script_data, piece_image)
    script_data["lines"].each do |line_data|
      puts "👨🏻 Creating character #{line_data['character']}"

      # Create or find the character
      character = Character.find_or_create_by(name: line_data["character"], piece_id: piece_image.piece.id)

      puts "🗣️ Creating Line for character #{line_data['character']}"

      # Create the Line record
      line = Line.create!(
        character: character,
        text: line_data["text"],
        order: line_data["order"],
        piece_image_id: piece_image.id
      )

      # Now associate the PieceLine with the created Line
      create_piece_line(line, character, piece_image, line_data["order"])
    end
  end

  private

  def create_piece_line(line, character, piece_image, order)
    puts "🔗 Creating PieceLine for Line ID #{line.id} and Character ID #{character.id}"

    # Create the PieceLine record with the necessary fields
    PieceLine.find_or_create_by(
      piece_id: piece_image.piece.id,
      character_id: character.id,
      line_id: line.id,
      order: order
    ) do |piece_line|
      # You can add additional logic here if needed, but we assume the attributes are enough
      piece_line.save!
    end

    puts "PieceLine created/associated with Line ID #{line.id}, Character ID #{character.id}, and PieceImage ID #{piece_image.id}"
  end
end
