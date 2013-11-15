class CabMailer < ActionMailer::Base
  default from: 'notifications@pennlist.co'
  
  def cab_update(messager, poster, message, advertisement, email_count)
    
    @messager = messager
    @poster = poster
    @message = message
    @advertisement = advertisement
    
    mail(:to => "#{@poster.name} <#{@poster.email}>", :subject => "PennList - #{@advertisement.title}", :from => "#{@messager.name} <#{@messager.email}>")
  end
end