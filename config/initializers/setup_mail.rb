require "development_mail_interceptor"

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => 'pennlist.co',
  :enable_starttls_auto => true
}
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?