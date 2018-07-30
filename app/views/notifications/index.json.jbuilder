json.array! @notifications do |notification|
  json.id notification.id
  json.recipient notification.recipient.name
  json.actor notification.actor.name
  json.action notification.action	
  json.notifiable notification.notifiable
  json.url post_path(notification.notifiable)
  
  

end