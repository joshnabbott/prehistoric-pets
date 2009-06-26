jQuery(document).ready(function($) {
  $('#product_post_o_matisize').click(function() {
    $('#post_o_matic_posting').toggle();
  })

  // set form styles
  $(':password').addClass('text_field');
  $(':text').addClass('text_field');
  $(':password').addClass('text_field');
  $(':checkbox').addClass('check_box');
  $(':submit').addClass('submit');
})

// For cropping
function setCropValues(c) {
  $('#crop_x').val(c.x);
  $('#crop_y').val(c.y);
  $('#crop_width').val(c.w);
  $('#crop_height').val(c.h);
}

// This method is used by swfupload for the 'upload_start_handler' callback.
// It's being used to set post data from other form fields in the form so more than just an asset can be uploaded.
// Keep in mind that when uploading multiple files, any other form data will be applied to all assets being uploaded.
function uploadStartFunction(file) {
  setSwfUploadPostParams(this);
}
function queueCompleteFunction(file) {
  // Basically this will redirect to list view of the images just uploaded
  redirectTo(document.location.href.replace('/new',''));
}
function setSwfUploadPostParams(object) {
  params = $("form#new_image").formHash();
  return object.setPostParams(params);
}
function redirectTo(url) {
  document.location.href = url;
}