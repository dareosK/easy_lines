puts "Cleaning up database..."
Line.destroy_all
PieceImage.destroy_all
Character.destroy_all
Piece.destroy_all
User.destroy_all
puts "Database cleaned!"

puts "Creating User..."
user = User.create!(email: "test@test.com", password: "123456")
puts "User created: #{user.email}"

puts "Creating Piece..."
piece = Piece.create!(title: "Hamlet", role: "Hamlet", user: user)
puts "Piece created: #{piece.title}"

puts "Attaching images to Piece..."
image_path = Rails.root.join("app", "assets", "images", "hamlet1.jpg")
piece.images.attach(io: File.open(image_path), filename: "hamlet1.jpg")
image_path = Rails.root.join("app", "assets", "images", "hamlet2.jpg")
piece.images.attach(io: File.open(image_path), filename: "hamlet2.jpg")
puts "Images attached: #{piece.images.count}"

puts "Creating Characters..."
hamlet = piece.characters.create!(name: "Hamlet", voice: "en-US-Wavenet-A")
ophelia = piece.characters.create!(name: "Ophelia", voice: "en-US-Wavenet-B")
puts "Characters created: #{piece.characters.pluck(:name).join(', ')}"

puts "Creating Piece Images..."
image1 = piece.piece_images.create!(order: 0)
image2 = piece.piece_images.create!(order: 1)
puts "Piece images created: #{piece.piece_images.count}"

puts "Creating Lines for Characters..."
# Lines for Hamlet
image1.lines.create!(character: hamlet, text: "To be, or not to be...", order: 0)
image1.lines.create!(character: hamlet, text: "I am thy father's spirit...", order: 1)

# Lines for Ophelia
image1.lines.create!(character: ophelia, text: "Good my lord...", order: 2)
image2.lines.create!(character: ophelia, text: "I shall obey, my lord...", order: 0)
puts "Lines created: #{Line.count}"

puts "Seed data successfully loaded!"
