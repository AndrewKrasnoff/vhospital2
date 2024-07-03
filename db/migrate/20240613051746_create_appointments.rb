class CreateAppointments < ActiveRecord::Migration[7.1]

  def change
    create_table :appointments, id: :uuid do |t|
      t.references :doctor,  type: :uuid, null: false, foreign_key: { to_table: 'users' }
      t.references :patient, type: :uuid, null: false, foreign_key: { to_table: 'users' }
      t.text       :question
      t.text       :answer

      t.timestamps
    end
  end

end
