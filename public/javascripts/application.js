jQuery(document).ready(function($) {
  $('a[rel*=facebox]').facebox();
  $("ul#announcement_tabs").tabs();

  // toggle videos on homepage
  $('div#videos ul#thumbnails > li a').click(function() {
    text = '<embed width="328" height="254" type="application/x-shockwave-flash" flashvars="m='+this.id+'&v=2&type=video" src="http://lads.myspace.com/videos/vplayer.swf"/>'
    $('div#videos div#video').html(text);
    $('div#videos ul#thumbnails > li a').removeClass('selected');
    $(this).addClass('selected');
    return false;
  })

  // handle items in cart with cached pages
  $('li#cart_link').html('<a href="/cart/items">' + cart_text($.cookie('items_in_cart')) + '</a>');
})

function cart_text(item_count) {
  if(item_count == null) {
    item_count = 0;
  }
  if(item_count == 1) {
    return item_count + ' item in cart';
  } else {
    return item_count + ' items in cart';
  }
}