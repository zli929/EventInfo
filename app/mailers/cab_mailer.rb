class CabMailer < ActionMailer::Base
  default from: 'notifications@pennlist.co'
  
  def cab_update(original_owner, joiner, join_or_leave)
    
    
    @cab_departure = joiner
    @cab_share = original_owner
    @messager = joiner.user
    @poster = original_owner.user
    @joining_cab = join_or_leave
    
    if joining_cab
    mail(:to => "#{@poster.name} <#{@poster.email}>", :subject => "#{@messager.name}has joined your cab!", :from => "#{@messager.name} <#{@messager.email}>")
    else
    mail(:to => "#{@poster.name} <#{@poster.email}>", :subject => "#{@messager.name}has joined your cab!", :from => "#{@messager.name} <#{@messager.email}>")
    end
  end
end