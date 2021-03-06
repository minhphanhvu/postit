# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Comment.destroy_all
Category.destroy_all
PostCategory.destroy_all
Vote.destroy_all

test_user = User.create!(username: 'testUser', email: 'test@gmail.com', password: 'password', role: 'admin')

nancy = User.create!(username: 'Nancy', email: 'nancy@gmail.com', password: 'password')
victor = User.create!(username: 'Victor', email: 'victor@gmail.com', password: 'password')
chili = Post.create!(title: 'How to make chili oil', url: 'woksoflife.com', description: 'great recipe on how to make chili oil', creator: nancy)
compost = Post.create!(title: 'How to make compost', url: 'urbangardening.com', description: 'compost recipe using coffee grounds', creator: nancy)
bok_choy = Post.create!(title: 'Why bok choy is great for cats', url: 'loveyourcats.com', description: "argument for more greens in your cat's diet", creator: victor)

Comment.create!(body: 'I agree!', creator: nancy, post: bok_choy)
Comment.create!(body: 'This looks delicious!', creator: victor, post: chili)
Comment.create!(body: "I'm commenting on my own post.", creator: nancy, post: chili)

recipes = Category.create!(name: "recipes")
food = Category.create!(name: "food")
cat = Category.create!(name: "cat")

PostCategory.create!(post: chili, category: recipes)
PostCategory.create!(post: chili, category: food)
PostCategory.create!(post: bok_choy, category: food)
PostCategory.create!(post: bok_choy, category: cat)

Vote.create(user_id: 1, vote: true, voteable: Post.find(2))
Vote.create(user_id: 1, vote: false, voteable: Comment.find(1))
Vote.create(user_id: 2, vote: true, voteable: Post.find(2))
