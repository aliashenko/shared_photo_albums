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
  $('.circle.profile_picture, .user_avatar_edit').hover(function(){
    $('.user_avatar_edit').show();
  }, function() {
    $('.user_avatar_edit').hide();
  });

  $('.photo').hover(function() {
    $('.delete_photo').show();
  }, function() {
    $('.delete_photo').hide();
  });

  $('.profile_background').hover(function() {
    $('.profile_background_edit').show();
  }, function() {
    $('.profile_background_edit').hide();
  });

  $('.minimize_images').resizeimage();
  $('.dropdown-button').dropdown({hover: false, alignment: 'right', constrain_width: false});

  $(document).on('click', '.mdi-content-clear', function() {
    var $album_viewers = $('#share_album_album_viewers');
    var user_ids = $album_viewers.val().split(' ');
    user_ids.splice( $.inArray($(this).parent().data('id').toString(), user_ids), 1 );
    $album_viewers.val(user_ids.join(' '));
    $(this).parent().remove();
  });

  $(document).on('input', '#search_contacts', function() {
    var users = $('#share_album_album_viewers').val().split(',');
    var url = $(this).data('url');
    var userName = $(this).val();

    if (userName.length >= 2) {
      $.get(url,
        {'user_name': userName},
        function(result) {
          $('#search_contacts').autocomplete({
            source: result,
            select: function(event, ui) {
              var users_array = users.toString().split(' ');
              if ($.inArray(ui.item.value.toString(), users_array) == -1) {
                var user_data = { name: ui.item.user_name, id: ui.item.value };
                users.push(ui.item.value.toString());
                userNameContainer = ich.name_block(user_data);
                $('#name_block_search').append(userNameContainer);
                $('#share_album_album_viewers').val(users.join(' '));
              }
              $(this).val('');
              return false; // Prevent the widget from inserting the value.
            },
            focus: function(event, ui) {
              $(this).val(ui.item.user_name);
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
