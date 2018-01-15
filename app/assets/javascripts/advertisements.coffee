@init_click_on_advitesement = () ->
  $('.advertisement').click ->
    advitesement_id = $(this).attr('id')
    count_clicks(advitesement_id)


count_clicks = (advitesement_id) ->
  $.ajax({
    type: "PUT",
    url: "/admin/click_on_advertisements/#{advitesement_id}",
    success: null,
    dataType: 'script'
  })
