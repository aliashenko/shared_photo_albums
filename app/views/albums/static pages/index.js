(function ($) {
  $.fn.resizeimage = function (options) {
    var defaults = {
      maxHeight: 180,
      minimize: true,
      ratio: 0
    }

    options = $.extend(defaults, options);
    return this.each(function(){
      var origin = $(this);

      function updateOptions() {
        if (origin.data('maxHeight') != undefined)
          options.maxHeight = origin.data('maxHeight');
        if (origin.data('minimize') != undefined)
          options.minimize = origin.data('minimize');
        if (origin.data('ratio') != undefined)
          options.ratio = origin.data('ratio');
      }

      updateOptions();

      var originalWidth = origin.width();
      var originalHeight = origin.height();
      var windowWidth = window.outerWidth;
      var windowHeight = window.outerHeight;

      var widthPercent = originalWidth / windowWidth;
      var heightPercent = originalHeight / windowHeight;

      var newWidth = 0;
      var newHeight = 0;
      var ratio = 0;

      if(options.minimize) {
        ratio = options.maxHeight / originalHeight; // get ratio for scaling image
        newWidth = originalWidth * ratio;
        newHeight = options.maxHeight;
      }
      else {
        if (widthPercent > heightPercent) {
          ratio = originalHeight / originalWidth;
          newWidth = windowWidth * 0.9;
          newHeight = windowWidth * 0.9 * ratio;
        }
        else {
          ratio = originalWidth / originalHeight;
          newWidth = (windowHeight * 0.9) * ratio;
          newHeight = windowHeight * 0.9;
        }
      };
      origin.css("height", newHeight);
      origin.css("width", newWidth);
    });

  };

  $(function() {
    $('.fullsize').resizeimage({minimize: false});
  });
}(jQuery));

(function ($) {
  $(function() {
    $('.album.card-image, .album.card-title').click(function() {
      window.location.href='show.html'
    });
    $('.modal-trigger').leanModal();
    $('.dropdown-button').dropdown({hover: false, alignment: 'right', constrain_width: false});
    $('.minimize_images').resizeimage();
    $('.arrow.previous').click(function() {
      window.location.href='show_photo.html';
    });
    $('.arrow.next').click(function() {
      window.location.href='show_photo_2.html';
    });
    $('.circle.profile_picture, .user_avatar_edit').hover(function(){
      $('.user_avatar_edit').show();
    }, function() {
      $('.user_avatar_edit').hide();
    });

    $('.profile_background').hover(function() {
      $('.profile_background_edit').show();
    }, function() {
      $('.profile_background_edit').hide();
    });

    $('i.search').click(function() {
      $('form.search').show()
      $('i.search').hide();
    });
  });
}(jQuery));
