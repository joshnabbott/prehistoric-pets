#TODO: Should probably make it possible to pass all options via swfupload_tag
module Admin::SwfuploadHelper
  def swfupload_tag(options = {})
    options = swfupload_defaults.update(options)

    content_for :admin_stylesheets, stylesheet_link_tag("swfupload/default")
    content_for :admin_javascripts,  javascript_include_tag('jquery.field', 'swfupload/swfupload', 'swfupload/swfupload.queue', 'swfupload/fileprogress', 'swfupload/handlers')
    content_for :admin_document_ready, swfupload_javascript(options)

    swfupload_html
  end

private
  def swfupload_defaults
    {
      :flash_url              =>  '/swfupload/swfupload.swf', # where is the flash located
      :upload_url             =>  swfupload_admin_images_path, # what url process the uploads?
      :file_size_limit        =>  100.megabytes,
      :file_types             =>  ['*.*'],
      :file_types_description => 'All Files',
      :file_upload_limit      =>  100, # how many files can be simultaneously uploaded?
      :file_queue_limit       =>  0,
      :debug                  => false,
      :button_text            => 'Upload Files',
      :queue_complete_handler => 'queueCompleteFunction'
    }
  end

  def swfupload_html
    <<-CODE
      <fieldset>
        <div class="fieldset flash" id="fsUploadProgress"><span class="legend">Upload Queue</span></div>
        <div id="divStatus">0 Files Uploaded</div>
          <div>
            <span id="spanButtonPlaceHolder"></span>
            <input id="btnCancel" type="button" value="Cancel All Uploads" onclick="swfu.cancelQueue();" disabled="disabled" style="margin-left: 2px; font-size: 8pt; height: 29px;" />
          </div>
        </div>
      </fieldset>
    CODE
  end

  def swfupload_javascript(options = {})
    <<-CODE
      var swfu;
      var settings = {
        flash_url : "#{options[:flash_url]}",
        upload_url: "#{options[:upload_url]}",
        file_size_limit : "#{options[:file_size_limit]}",
        file_types : "#{options[:file_types]}",
        file_types_description : "#{options[:file_types_description]}",
        file_upload_limit : #{options[:file_upload_limit]},
        file_queue_limit : #{options[:file_queue_limit]},
        custom_settings : {
          progressTarget : "fsUploadProgress",
          cancelButtonId : "btnCancel"
        },
        post_params : { _session_id : "#{request.session_options[:id]}" },
        debug: #{options[:debug]},

        // Button settings
        button_width: "65",
        button_height: "29",
        button_placeholder_id: "spanButtonPlaceHolder",
        button_text: '<span class="theFont">#{options[:button_text]}</span>',
        button_text_style: ".theFont { font-size: 16; }",
        button_text_left_padding: 12,
        button_text_top_padding: 3,

        // The event handler functions are defined in handlers.js
        file_queued_handler : fileQueued,
        file_queue_error_handler : fileQueueError,
        file_dialog_complete_handler : fileDialogComplete,
        // upload_start_handler : uploadStart,
        upload_start_handler : uploadStartFunction,
        upload_progress_handler : uploadProgress,
        upload_error_handler : uploadError,
        upload_success_handler : uploadSuccess,
        upload_complete_handler : uploadComplete,
        queue_complete_handler : #{options[:queue_complete_handler]}
      };

      swfu = new SWFUpload(settings);
    CODE
  end
end