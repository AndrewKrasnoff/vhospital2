FactoryBot.create(:user, role: :admin, phone: '1234567890')

puts '✅ | Admin user created'
puts '🔑 | phone:     1234567890'
puts '🔑 | password:  password'
puts '🔥 | -'
puts

FactoryBot.create_list(:category, 5)

puts '✅ | Categories created'
puts '🔥 | -'
puts

10.times do
  FactoryBot.create(:user, role: :doctor, category: Category.all.sample)
end

puts '✅ | Doctors created'
puts '🔥 | -'
puts

FactoryBot.create_list(:user, 15, role: :patient)

puts '✅ | Patients created'
puts '🔥 | -'
puts

30.times do
  FactoryBot.create(:appointment,
                    doctor: User.where(role: :doctor).sample,
                    patient: User.where(role: :patient).sample)
end

puts '✅ | Open (without answer) appointments ceated'
puts '🔥 | -'
puts

30.times do
  FactoryBot.create(:appointment, :with_answer,
                    doctor: User.where(role: :doctor).sample,
                    patient: User.where(role: :patient).sample)
end

puts '✅ | Closed (with answer) appointments ceated'
puts '🔥 | -'
puts
