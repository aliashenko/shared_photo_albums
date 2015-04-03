// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require materialize-sprockets
//= require dropzone
//= require jquery-ui/autocomplete
//= require_tree .

var ready;
ready = function() {
  $('.dropdown-button').dropdown({hover: false, alignment: 'right', constrain_width: false});
  $('.modal-trigger').leanModal();
  $('#search_contacts').on('input', function() {
    var url = $(this).data('url');
    var userName = $(this).val();
    var searchContainer = $(this);

    if (userName.length >= 2) {
      $.get(url,
        {'user_name': userName},
        function(result) {
          $('#search_contacts').autocomplete({
            source: result,
            select: function(event, ui) {
              searchContainer.val(ui.item.user_name);
              return false; // Prevent the widget from inserting the value.
            },
            focus: function(event, ui) {
              searchContainer.val(ui.item.label);
              return false; // Prevent the widget from inserting the value.
            }
          });
        }
      );
    };
  });
};
$(document).ready(ready);
$(document).on('page:load', ready);
