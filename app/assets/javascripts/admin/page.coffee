@switvh_advanced_layout = () ->
  menu_item_selected = $('#page_layout :selected').text()
  switch menu_item_selected
    when 'georgia', 'hawaii', 'idaho', 'illinois', 'iowa'
      $('#advanced-layout').collapse('show')
    else
      $('#advanced-layout').collapse('hide')
      break
