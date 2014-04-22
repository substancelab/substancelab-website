//= require jquery.equalheights.min.js

(function( $ ) {
  $.fn.adjustEqualHeights = function(method) {
    var methods = {
      init: function(options) {
        var $this = $(this);
        $this.adjustEqualHeights('adjustEqualHeights');
      },

      adjustEqualHeights: function() {
        var $this = $(this);

        $(document).ready(function() {
          $this.adjustEqualHeights('adjustOnAction');
        });
        $(window).resize(function() {
          $this.adjustEqualHeights('adjustOnAction');
        });
      },

      adjustOnAction: function() {
        var $this = $(this);

        $this.each(function(index, element) {
          $(element).css({height: ""}).equalHeights();
        });
      }
    };

    // Method calling logic
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || ! method) {
      return methods.init.apply(this, arguments);
    } else {
      $.error('Method ' +  method + ' does not exist on jQuery.adjustEqualHeights');
    };

    // Return this to ensure chainability
    return this.each(function() {
      var $this = $(this);
    });
  };
})( jQuery );
