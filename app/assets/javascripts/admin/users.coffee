@admin_user_pages_dropdown = () ->
  $('#admin-user-pages').change ->
    selected = $('#admin-user-pages').val();
    switch selected
      when "all"
        window.location.href = '/admin/users'
      when 'active subscribers'
        window.location.href = '/admin/active_subscribers'
      when 'latest online payments'
        window.location.href = '/admin/latest_online_payments'
      when 'logged in from many ips'
        window.location.href = '/admin/sign_in_ips'

