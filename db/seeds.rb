Article.destroy_all
User.destroy_all

puts "Seeding local data using faker ..."

users = []

10.times do
  user =
    User.create!(
      username:
        Faker::Internet
          .unique
          .username(specifier: 3..15)
          .gsub(/[^a-z0-9_]/, "_"),
      email: Faker::Internet.unique.email,
      password: "passowrd123"
    )
  users << user
end

30.times do
  Article.create!(
    title: Faker::Book.title[0..49],
    description: Faker::Lorem.paragraph_by_chars(number: 200),
    user: users.sample
  )
end

puts "Seeding complete! create #{User.count} Users And #{Article.count} Articles "
