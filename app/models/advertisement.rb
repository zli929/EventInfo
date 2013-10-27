class Advertisement < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable

  validates :tag_list, :length => { :maximum => 30 } # Limit to 30 tags max
  validate :each_tag

  validates :user_id, presence: true
  validates :title, presence: true
  validates :price, presence: true
  
  has_many :advertisement_images, dependent: :destroy
  has_many :advertisement_comments, dependent: :destroy
  
  accepts_nested_attributes_for :advertisement_images, :reject_if => lambda { |t| t['advertisement_image'].nil? }
  
  def each_tag
    for tag in tag_list
      errors.add(:tag, "too long (maximum is 50 characters)") if tag.length > 50
      errors.add(:tag, "can't contain a period") if tag.include? '.'
    end
  end
end
