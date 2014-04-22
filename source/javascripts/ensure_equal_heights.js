//= require jquery.equalheights.min.js

(function($) {
  $.fn.adjustEqualHeights = function(method) {
    var methods = {
      init: function(options) {
        $(this).adjustEqualHeights('bindEvents');

        // Return this to ensure chainability
        return this.each(function() {
          var $this = $(this);
        });
      },

      adjustHeights: function() {
        $(this).each(function(index, element) {
          $(element).equalHeights();
        });
      },

      bindEvents: function() {
        var $this = $(this);

        $(document).ready(function() {
          $this.adjustEqualHeights('adjustHeights');
        });
        $(window).resize(function() {
          $this.adjustEqualHeights('resetHeights');
          $this.adjustEqualHeights('adjustHeights');
        });
      },

      resetHeights: function() {
        $(this).each(function(index, element) {
          $(element).css({
            height: ""
          });
        });
      }
    };

    // Method calling logic
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      $.error('Method ' + method + ' does not exist on jQuery.adjustEqualHeights');
    };
  };
})(jQuery);
