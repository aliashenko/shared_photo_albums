(function ($) {
  $.fn.resizeimage = function (options) {
    var defaults = {
      maxHeight: 180,
      ratio: 0
    }

    options = $.extend(defaults, options);
    return this.each(function(){
      var origin = $(this);

      function updateOptions() {
        if (origin.data('maxHeight') != undefined)
          options.maxHeight = origin.data('maxHeight');
        if (origin.data('ratio') != undefined)
          options.ratio = origin.data('ratio');
      }

      updateOptions();

      var originalWidth = origin.width();
      var originalHeight = origin.height();

      var newWidth = 0;
      var newHeight = 0;
      var ratio = 0;

      ratio = options.maxHeight / originalHeight; // get ratio for scaling image
      newWidth = originalWidth * ratio;
      newHeight = options.maxHeight;

      origin.css("height", newHeight);
      origin.css("width", newWidth);
    });

  };
}(jQuery));
