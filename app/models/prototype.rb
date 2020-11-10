class Prototype < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments , :dependent=>:delete_all

  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true
  validates :user_id, presence: true
  
end
