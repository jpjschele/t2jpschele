class New < ApplicationRecord
	validates :title, presence: true, uniqueness: true
	validates :subtitle, length: {maximum: 300}
	has_many :comments, dependent: :delete_all
	validates :body, presence: true
end
