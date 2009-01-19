/*jQuery(document).ready(function($) {
  $('div.pagination a').livequery('click', function() {
    $('#announcements').load(this.href)
    return false
  })
})*/
$('.pagination a').livequery('click', function() { 
  $.get(this.href, function(data) { 
    $('body.home #announcements').html(data);
  })
  return false;
});

jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})
jQuery(document).ready(function($) {
  $('a[rel*=facebox]').facebox() 
})