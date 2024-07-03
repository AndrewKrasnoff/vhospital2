FactoryBot.create(:admin, phone: '1234567890')

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
  FactoryBot.create(:doctor, category: Category.all.sample)
end

puts '✅ | Doctors created'
puts '🔥 | -'
puts

FactoryBot.create_list(:patient, 15)

puts '✅ | Patients created'
puts '🔥 | -'
puts

30.times do
  FactoryBot.create(:appointment,
                    doctor: Doctor.all.sample,
                    patient: Patient.all.sample)
end

puts '✅ | Open (without answer) appointments created'
puts '🔥 | -'
puts

30.times do
  FactoryBot.create(:appointment, :with_answer,
                    doctor: Doctor.all.sample,
                    patient: Patient.all.sample)
end

puts '✅ | Closed (with answer) appointments created'
puts '🔥 | -'
puts
