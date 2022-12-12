require 'faker'

puts "🌱 Seeding db..."

puts "Creating users..."


u1 = User.create(name: "Aki", password: "aki")
u2 = User.create(name: "Lore", password: "lore")
u3 = User.create(name: "Crock", password: "crock")
u4 = User.create(name: "Panda", password: "panda")

20.times do |i|
    User.create(name: Faker::Name.unique.name, password: Faker::Internet.unique.password)
end


puts "Creating topics..."

20.times do |i|
    Topic.create(title: "Topic# #{i}", user_id: Faker::Number.between(from: 1, to: 24), open: true)
end

20.times do |i|
    Topic.create(title: "Topic# #{i + 20}", user_id: Faker::Number.between(from: 1, to: 4), open: true)
end

20.times do |i|
    Topic.create(title: "Topic# #{i + 40}", user_id: Faker::Number.between(from: 1, to: 24), open: false, winner_idea: Faker::Number.between(from: 1, to: 100) )
end

t1 = Topic.create(title: "Places to hide bone", user_id: 1, open: true)

ideas = ["Under the pillow", "In the corner of the desk", "In the mole's hole", "Inside the crocky", "Don't hide it, eat it all!"]

ideas.each do |i|
    Idea.create(body: i, user_id: Faker::Number.between(from: 1, to: 4) , topic: t1)
end

40.times do |i|
    Like.create(idea_id: Faker::Number.between(from: 1, to: 5), user_id: Faker::Number.between(from: 1, to: 24) )
end

t1 = Topic.create(title: "What to do on Christmas-Eve", user_id: 2, open: true)

ideas = ["Go see Moulin Rouge", "Dinner at a Restaurant", "Quiet evening at home", "Dinner with Friends"]

ideas.each do |i|
    Idea.create(body: i, user_id: Faker::Number.between(from: 1, to: 4) , topic: t1)
end

40.times do |i|
    Like.create(idea_id: Faker::Number.between(from: 6, to: 10), user_id: Faker::Number.between(from: 1, to: 24) )
end


puts "Creating ideas..."

100.times do |x|
    Idea.create(body: "Idea# #{x}", user_id: Faker::Number.between(from: 1, to: 4), topic_id: Faker::Number.between(from: 1, to: 40))
end

100.times do |x|
    Idea.create(body: "Idea# #{x}", user_id: Faker::Number.between(from: 1, to: 24), topic_id: Faker::Number.between(from: 1, to: 40))
end


puts "Creating likes..."


100.times do |i|
    Like.create(idea_id: Faker::Number.between(from: 40, to: 60), user_id: Faker::Number.between(from: 1, to: 4) )
end

100.times do |i|
    Like.create(idea_id: Faker::Number.between(from: 1, to: 100), user_id: Faker::Number.between(from: 1, to: 4) )
end

100.times do |i|
    Like.create(idea_id: Faker::Number.between(from: 100, to: 200), user_id: Faker::Number.between(from: 1, to: 24) )
end

# Seed your database here

puts "✅ Done seeding!"
