class Advertisement < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true
  
  has_many :advertisement_images, dependent: :destroy
  has_many :advertisement_comments, dependent: :destroy
  
  accepts_nested_attributes_for :advertisement_images, :reject_if => lambda { |t| t['advertisement_image'].nil? }
end
