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
      var windowWidth = window.innerWidth;
      var windowHeight = window.innerHeight;

      var widthPercent = originalWidth / windowWidth;
      var heightPercent = originalHeight / windowHeight;

      var newWidth = 0;
      var newHeight = 0;
      var ratio = 0;

      if(options.minimize) {
        ratio = options.maxHeight / originalHeight; // get ratio for scaling image
        newWidth = originalWidth * ratio;
        newHeight = originalHeight * ratio;
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
})(jQuery);

$(document).ready(function() {
  $(".dropdown-button").dropdown({hover: false, alignment: 'right', constrain_width: false});
  $('.slider').resizeimage();
  $('.fullsize').resizeimage({minimize: false});
});
