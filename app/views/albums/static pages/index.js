(function ($) {
  $.fn.resizeimage = function () {
    return this.each(function() {
      var maxHeight = 180;
      var ratio = 0;
      var width = $(this).width();
      var height = $(this).height();

      // Check if current height is larger than max
      if(height > maxHeight) {
        ratio = maxHeight / height; // get ratio for scaling image
        $(this).css("height", maxHeight);
        $(this).css("width", width * ratio);
        width = width * ratio;
        height = height * ratio;
      };
    });
  }
})(jQuery);

$(document).ready(function() {
  $(".dropdown-button").dropdown({hover: false, alignment: 'right', constrain_width: false});
  $('.slider').resizeimage();
});
