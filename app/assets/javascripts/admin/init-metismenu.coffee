document.addEventListener 'turbolinks:load', ->

  $("body").addClass("loaded")
  $('#sidebar-menu, #customize-menu').metisMenu activeClass: 'open'
  $('#sidebar-collapse-btn').on 'click', (event) ->
    event.preventDefault()
    $('#app').toggleClass 'sidebar-open'
    return
  $('#sidebar-overlay').on 'click', ->
    $('#app').removeClass 'sidebar-open'
    return
  return






