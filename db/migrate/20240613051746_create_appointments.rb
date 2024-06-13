class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments, id: :uuid do |t|
      t.uuid :doctor_id
      t.uuid :patient_id
      t.text :question
      t.text :answer

      t.timestamps
    end
  end
end
