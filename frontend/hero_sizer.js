console.log('Loading heroSizer');
(function( $ ) {
  $.fn.heroSizer = function(method) {
    var methods = {
      init : function( options ) {
        var $this = $(this);
        $this.heroSizer('setSize');
      },

      navbarHeight: function() {
        return $('.nav-bar').outerHeight();
      },

      setSize: function() {
        var $this = $(this);
        var viewportHeight = $this.heroSizer('viewportHeight');
        var navbarHeight = $this.heroSizer('navbarHeight');
        var height = viewportHeight - navbarHeight * 2;
        $this.height(height);
      },

       viewportHeight: function() {
        return $(window).height()
      }
    };

    // Method dispatch
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || ! method) {
      return methods.init.apply(this, arguments);
    } else {
      $.error('Method ' +  method + ' does not exist on jQuery.heroSizer');
    };

    // Return this to ensure chainability
    return this.each(function() {
      var $this = $(this);
    });
  };
})( jQuery );
