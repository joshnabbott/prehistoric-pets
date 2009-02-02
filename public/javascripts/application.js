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
})