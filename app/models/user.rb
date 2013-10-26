class User < ActiveRecord::Base
  before_save :ensure_authentication_token
  include ActiveModel::ForbiddenAttributesProtection
  
  has_many :advertisements, dependent: :destroy
  has_many :advertisement_comments, dependent: :destroy
  
  # :confirmable, 
  devise  :database_authenticatable, :registerable, :recoverable, :rememberable, 
          :trackable, :validatable, :omniauthable, :confirmable,
          :omniauth_providers => [:facebook]

  attr_accessor :name

  # Set up Validations
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
    format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: { case_sensitive: false }  

  def email_validation_required?
    :facebookuid.nil?
  end

  VALID_EMAILS = %w(upenn.edu)
  validates_format_of :email, :with => /#{VALID_EMAILS.map{|a| Regexp.quote(a)}.join('|')}/, :message => "You must use an upenn.edu email address",
    :if => :email_validation_required?
    
  # Allows for a quick pull of the User's name without having to save said name
  after_initialize :get_name 
  def get_name
    self.name = (first_name || "") + " " + (last_name || "")
  end

  def password_validation_required?
    :encrypted_password.nil? || !@password.blank? || !@password_confirmation.blank?
  end
    
  # Password validations update  
  validates :password, presence: true, length: { minimum: 8 },
    :if => :password_validation_required?
  validates :password_confirmation, presence: true,
    :if => :password_validation_required?

  before_save { email.downcase! }
  before_save :create_remember_token

  def self.find_for_oauth(provider, uid, first_name, last_name, email, token, signed_in_resource=nil)
    
    # Dummy data for passwords
    password_placeholder = Devise.friendly_token[0,20]
    
    
    # Check to see if user has previously logged in
    if provider == "facebook"
      # Test to see if this authentication path has ever been used before
      
      user = User.where(:facebookuid => uid).first
     
      unless user
        # Test to see if the user's email has been used before
        user = User.where(:email => email).first        
                
        if user
          user.facebookuid = uid
        elsif valid_facebook_group?(token)
          user = User.create(:first_name => first_name,
                     :last_name => last_name,
                     :facebookuid => uid,
                     :email => email,
                     :password => password_placeholder,
                     :password_confirmation => password_placeholder,
                     :confirmed_at => Time.now,
                     :nativelogin => false,
                     )        
        end
      end
    end
    user
  end

  def skip_confirmation!
      self.confirmed_at = Time.now
  end
  
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end
  
  #Need to understand protected versus private better. 
  protected 
    def self.valid_facebook_group?(token)
        user = FbGraph::User.me(token)
        user = user.fetch
        
        raise user.groups.to_yaml
      
        !user.groups.detect{|f| f.identifier.in?(['110130752488165', '169174513170821', '539654862754959'])}.nil?
    end
    
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end  
    
    def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
