@load_carousel = ->
  $('#myCarousel').carousel();

$(document).ready load_carousel()
$(document).on 'page:load', load_carousel()