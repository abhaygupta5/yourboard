class Notifications
    constructor: ->
      @getNewNotifications()
      @notifications = $("[data-behavior='notifications']")

      if @notifications.length > 0
        @handleSuccess @notifications.data('notifications')

    getNewNotifications: ->
      $.ajax(
        url: '/notifications.json'
        dataType: 'JSON'
        method: 'GET'
        success: @handleSuccess
      )

    
    handleSuccess: (data) =>

                  
          items = $.map data, (notification) ->
                  console.log(data)
                  "<div style='word-break: break-all;'><a class='dropdown-item' href='/notifications/#{notification.id}/mark_as_read' data-behavior = 'notification-link' id='#{notification.id}'><p><strong>#{notification.actor}</strong> posted a new comment on post <br><strong>#{notification.notifiable.title}</strong></p></a></div><hr style='margin-top:0;'>"
                  
            
          
          if items.length >0
            $("[data-behavior='notification-items']").html(items)
            $("[data-behavior='unread-count']").html("<span style='position:absolute;top:-2px;font-size:13px;background-color:red;color:white;width:16px;height:16px;border-radius:8px;margin:0;padding:2px;'>#{items.length}</span>") 
          else
            $("[data-behavior='notification-items']").html("<a href='#' class='dropdown-item'>No New Notifications</a>")  
          
        
          
        

jQuery ->
    new Notifications 