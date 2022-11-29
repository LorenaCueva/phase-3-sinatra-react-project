puts "🌱 Seeding db..."

puts "Creating users..."

u1 = User.create(name: "Aki", email: "aki@aki.com")
u2 = User.create(name: "Lorena", email: "lorenacueva@gmail.com")
u3 = User.create(name: "Crocky", email: "crocky@aki.com")
u4 = User.create(name: "Panda", email: "panda@panda.com")

puts "Creating topics..."

t1 = Topic.create(title: "Places to hide bone", user: u1, open: true)
t2 = Topic.create(title: "Restaurant to try:", user: u2, open: false)
t3 = Topic.create(title: "Places to hide from Dog:", user: u3, open: true)
t4 = Topic.create(title: "Ways to show more grumpusness:", user: u1, open: true)
t5 = Topic.create(title: "What to do this weekend", user: u2, open: false, updated_at: Time.now.getutc)

puts "Creating ideas..."

i1 = Idea.create(body: "Under the pillow", topic: t1, user: u1)
i2 = Idea.create(body: "Under the chair", topic: t1, user:u2)
i3 = Idea.create(body: "Ciudad in Georgetown", topic: t2 , user: u4)
i4 = Idea.create(body: "Close to the washing machine", topic: t3 , user: u4)
i5 = Idea.create(body: "Growl at any sound", topic: t4, user: u1)
i6 = Idea.create(body: "Go fishing", topic: t5, user: u4)
i7 = Idea.create(body: "Watch movies", topic: t5, user: u1)

t5.winner_idea = i6.id
t5.save
t2.winner_idea = i3.id
t2.save

l1 = Like.create(idea: i6, user: u2)
l2 = Like.create(idea: i6, user: u3)
l3 = Like.create(idea: i1, user: u1)
l4 = Like.create(idea: i1, user: u2)


# Seed your database here

puts "✅ Done seeding!"
