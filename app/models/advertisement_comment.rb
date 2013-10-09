class AdvertisementComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :advertisement
  
  
  validates :user_id, presence: true
  validates :comment, presence: true, length: { maximum: 140 }
end
