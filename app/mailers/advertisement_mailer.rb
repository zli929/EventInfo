class AdvertisementMailer < ActionMailer::Base
  default from: 'notifications@pennlist.co'
  
  def advertisement_update(messager, poster, message)
    @messager = messager
    @poster = poster
    @message = message
    
    mail(:to => ["#{@poster.name} <#{@poster.email}>", "#{@messager.name} <#{@messager.email}>"], :subject => "#{@messager.name} has sent you a comment")
  end
end