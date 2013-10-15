class AdvertisementMailer < ActionMailer::Base
  default from: 'notifications@pennlist.co'
  
  def advertisement_update(messager, poster, message, advertisement)
    @messager = messager
    @poster = poster
    @message = message
    @advertisement = advertisement
    
    mail(:to => "#{@poster.name} <#{@poster.email}>", :subject => "PennList - #{@advertisement.title}", :from => "#{@messager.name} <#{@messager.email}>")
  end
end