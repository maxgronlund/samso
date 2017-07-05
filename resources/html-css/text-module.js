$( window ).resize(function() {
  check_columns();
});

$(function() {
  check_columns();
});

function check_columns() {
  $(".col-size").each(function() {
    check_text_modules(this)
  });
}

function check_text_modules(col) {
  width = $(col).width();
  $(col).children(".text-module").each(function() {
    check_layout(this, width);
  });
}

function check_layout(text_module, width) {
  layout_div = $(text_module).find( ".layout" );
  layout = $(layout_div).attr('value')
  console.log(layout)
  switch(layout) {
    case 'alfa-romeo':
      alfa_romeo_content(text_module, width);
      alfa_romeo_image(text_module, width);
      break;
    default:
      break;
  }
}

function alfa_romeo_content(text_module, width) {
  content_box = $(text_module).find( ".content-box" );
  div_id    = "#" + $(content_box).attr('id');

  if(width < 451) {
    $(div_id).css({"float": "initial", "width" : "100%", "padding-left" : "0px"});
  } else {
    $(div_id).css({"float": "left", "width" : "66%", "padding-left" : "11px"});
  }

  $(content_box).children('.title').each(function() {
    if( 106 < width && width < 180) {
      $(this).css({'font-size':'1.2rem'});
    } else if( width < 107) {
      $(this).css({'font-size':'1.1rem'});
    } else {
      $(this).css({'font-size':'1.5rem'});
    }
  });
}

function alfa_romeo_image(text_module, width) {
  image_box = $(text_module).find( ".image-box" );
  div_id    = "#" + $(image_box).attr('id');
  if(width < 451) {
    $(div_id).css({"float": "initial", "width" : "100%"});

  } else {
    $(div_id).css({"float": "left", "width" : "33%"});
  }
}



