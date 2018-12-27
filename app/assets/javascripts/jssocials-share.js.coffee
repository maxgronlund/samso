# docs on http://js-socials.com/demos/
@init_share_buttons = () ->
  $('#shareRoundIcons').jsSocials
    showLabel: false
    showCount: false
    shareIn: "popup"
    shares: [
      'email'
      'twitter'
      'facebook'
      'linkedin'
    ]