class CabMailer < ActionMailer::Base
  default from: 'notifications@pennlist.co'
  
  def cab_update(status, cab_share, joiner)
    recipients = ''
    cab_share.cab_departures.each do |cab_departee|
      recipients = recipients + cab_departee.user.name + " <"+cab_departee.user.email+">, "
    end
    
    @participants = cab_share
    @joiner = joiner
    
    if status == 'joining'
      @status = true
      mail(:to => recipients, :subject => "PennList - #{joiner.user.name} has joined your cab!", :from => "#{joiner.user.name} <#{joiner.user.email}>")
    else
      @status = false
      mail(:to => recipients, :subject => "PennList - #{joiner.user.name} has left your cab!", :from => "#{joiner.user.name} <#{joiner.user.email}>")
    end
  end
end