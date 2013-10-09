class AdvertisementImage < ActiveRecord::Base
  belongs_to :advertisement
      
  has_attached_file :image, :styles => {
    thumb:  'x60>',
    small:  '150x150>',
    large:  '500x500>'
  }
end

