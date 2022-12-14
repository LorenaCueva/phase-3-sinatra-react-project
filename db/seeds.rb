require 'faker'

puts "🌱 Seeding db..."

puts "Creating users..."


u1 = User.create(name: "Aki", password: "aki")
u2 = User.create(name: "Lore", password: "lore")
u3 = User.create(name: "Crock", password: "crock")
u4 = User.create(name: "Panda", password: "panda")

6.times do |i|
    User.create(name: Faker::Name.unique.name, password: Faker::Internet.unique.password)
end


puts "Creating topics..."

5.times do |i|
    Topic.create(title: "Topic# #{i + 1}", user_id: 1, open: true)
end
5.times do |i|
    Topic.create(title: "Topic# #{i + 6}", user_id: 2, open: true)
end

5.times do |i|
    Topic.create(title: "Topic# #{i + 11}", user_id: Faker::Number.between(from: 1, to: 10), open: true)
end

5.times do |i|
    Topic.create(title: "Topic# #{i + 16}", user_id: Faker::Number.between(from: 1, to: 2), open: false, winner_idea: Faker::Number.between(from: 1, to: 50))
end



t1 = Topic.create(title: "Places to hide bone", user_id: 1, open: true)

ideas = ["Under the pillow", "In the corner of the desk", "In the mole's hole", "Inside the crocky", "Don't hide it, eat it all!"]

ideas.each do |i|
    Idea.create(body: i, user_id: Faker::Number.between(from: 1, to: 4) , topic: t1)
end

10.times do |i|
    Like.create(idea_id: Faker::Number.between(from: 1, to: 5), user_id: Faker::Number.between(from: 1, to: 10) )
end

t1 = Topic.create(title: "What to do on Christmas-Eve", user_id: 2, open: true)

ideas = ["Go see Moulin Rouge", "Dinner at a Restaurant", "Quiet evening at home", "Dinner with Friends"]

ideas.each do |i|
    Idea.create(body: i, user_id: Faker::Number.between(from: 1, to: 4) , topic: t1)
end

10.times do |i|
    Like.create(idea_id: Faker::Number.between(from: 6, to: 9), user_id: Faker::Number.between(from: 1, to: 10) )
end


puts "Creating ideas..."

20.times do |x|
    Idea.create(body: "Idea# #{x+10}", user_id: Faker::Number.between(from: 1, to: 2), topic_id: x + 1 )
end

30.times do |x|
    Idea.create(body: "Idea# #{x + 30}", user_id: Faker::Number.between(from: 1, to: 10), topic_id: Faker::Number.between(from: 1, to: 20))
end



puts "Creating likes..."

49.times do |i|
    Like.create(idea_id: i + 10 , user_id: Faker::Number.between(from: 1, to: 10) )
end

50.times do |i|
    Like.create(idea_id: Faker::Number.between(from: 1, to: 59) , user_id: Faker::Number.between(from: 1, to: 10) )
end




puts "✅ Done seeding!"
