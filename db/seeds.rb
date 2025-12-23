# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'

posts_file = File.read(Rails.root.join('posts.json'))
posts = JSON.parse(posts_file)

quotes_data = posts.map do |post|
  {
    contents: post['alt_text'],
    url: post['image_url'],
    twitter_url: post['post_url']
  }
end

EffinQuote.create(quotes_data)
