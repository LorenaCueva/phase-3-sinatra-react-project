puts "🌱 Seeding db..."

u1 = User.create(name: "Aki", email: "aki@aki.com")
u2 = User.create(name: "Lorena", email: "lorenacueva@gmail.com")
u3 = User.create(name: "Crocky", email: "crocky@aki.com")
u4 = User.create(name: "Panda", email: "panda@panda.com")

t1 = Topic.create(title: "Places to hide bone", user: u1, open: 1)
t2 = Topic.create(title: "Restaurant to try:", user: u2, open: 1)
t3 = Topic.create(title: "Places to hide from Dog:", user: u3, open: 1)
t4 = Topic.create(title: "Ways to be show more grumpusness:", user: u1, open: 1)

i1 = Idea.create(body: "Under the pillow", topic: t1, user: u1)
i2 = Idea.create(body: "Under the chair", topic: t1, user:u2)
i3 = Idea.create(body: "Ciudad in Georgetown", topic: t2 , user: u4)
i4 = Idea.create(body: "Close to the washing machine", topic: t3 , user: u4)
i5 = Idea.create(body: "Growl at any sound", topic: t4, user: u1)


# Seed your database here

puts "✅ Done seeding!"
