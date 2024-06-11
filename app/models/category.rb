# == Schema Information
#
# Table name: categories
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
