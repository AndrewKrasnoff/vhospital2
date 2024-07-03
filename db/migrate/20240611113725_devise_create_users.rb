# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.1]

  def change
    create_table :users, id: :uuid do |t|
      ## Devise
      t.string   :email,              null: false, default: ''
      t.string   :encrypted_password, null: false, default: ''
      t.datetime :remember_created_at

      t.string     :type
      t.string     :phone, limit: 10
      t.references :category, type: :uuid, foreign_key: true

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :phone, unique: true
  end

end
