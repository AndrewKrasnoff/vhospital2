# == Schema Information
#
# Table name: appointments
#
#  id         :uuid             not null, primary key
#  doctor_id  :uuid             not null
#  patient_id :uuid             not null
#  question   :text
#  answer     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :appointment do
    transient do
      answer { Faker::Lorem.sentence }
    end

    doctor   { association :doctor }
    patient  { association :patient }
    question { Faker::Lorem.sentence }

    trait :with_answer do
      after :create do |appointment, evaluator|
        appointment.update(answer: evaluator.answer)
      end
    end
  end
end
