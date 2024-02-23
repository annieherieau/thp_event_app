# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'
Faker::Config.locale='fr'
Faker::UniqueGenerator.clear

puts '_____SEEDING_____'
Attendance.destroy_all
User.destroy_all
Event.destroy_all
Admin.destroy_all
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
puts '---- reset tables ---'

5.times do |i|
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.paragraph(sentence_count: rand(2..5)),
    email: "user#{(i+1).to_s.rjust(2,'0')}@annieherieau.fr",
    password: "Azer1&"
  )
end
puts '---- 5 users ---'

attendance_total_count = 0
30.times do |i|
  event = Event.new(
    start_date: Faker::Date.between(from: 30.days.ago, to: Faker::Date.forward(days: 60)),
    # start_date: Faker::Time.between(from: DateTime.now, to: DateTime.now + 30, format: :short),
    duration: rand(1..60)*5,
    title: Faker::Lorem.paragraph(sentence_count: rand(1..2)),
    description: Faker::Lorem.paragraph(sentence_count: rand(6..20)),
    price: rand(0..2),
    location: Faker::Address.city,
    admin_user: User.all.sample,
    reviewed: [true, false].sample
  )
  event.validated = [true, false].sample if event.reviewed
  event.save

  if event.validated
    rand(0..4).times do |i|
      e = Event.last
      u = User.all.sample
      while u == e.admin_user || Attendance.where(event_id: e.id, user_id:u.id).length>0
        u = User.all.sample
      end
      Attendance.create!(
        event: e,
        user: u,
      )
      attendance_total_count += 1
    end
  end
end
puts "---- 30 events + #{attendance_total_count} attendances ---"

Admin.create!(
  email: 'kadmin@annieherieau.fr',
  password: 'Azer1&'
)

