(function( $ ) {
  $.fn.quoteSlider = function(method) {
    var methods = {
      init : function( options ) {
        var $this = $(this);
        $this.quoteSlider('setTimeout');
        $this.quoteSlider('showNextQuote');
      },

      setTimeout: function() {
        var $this = $(this);
        setTimeout(
          function() {
            $this.quoteSlider('setTimeout');
            $this.quoteSlider('showNextQuote');
          }
          , 10000
        );
      },

      // Returns all the quote elements
      quotes: function() {
        return this.children('blockquote');
      },

      // Returns the currently visible quote
      currentQuote: function() {
        return this.children('blockquote.current');
      },

      nextQuote: function() {
        var $this = $(this);
        var current_quote = $this.quoteSlider('currentQuote');
        var next = current_quote.next();

        if (next.size() > 0) {
          return next;
        } else {
          return $this.quoteSlider('quotes').first();
        };
      },

      showNextQuote: function() {
        var $this = $(this);
        var current_quote = $this.quoteSlider('currentQuote');
        var next_quote = $this.quoteSlider('nextQuote');

        $this.quoteSlider('showQuote', next_quote);
      },

      showQuote: function(quote) {
        var $this = $(this);
        var current_quote = $this.quoteSlider('currentQuote');
        current_quote.removeClass('current');

        var $quote = $(quote);
        $quote.addClass('current');
        return $quote;
      },

    };

    // Method calling logic
     if ( methods[method] ) {
       return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
     } else if ( typeof method === 'object' || ! method ) {
       return methods.init.apply( this, arguments );
     } else {
       $.error( 'Method ' +  method + ' does not exist on jQuery.tooltip' );
     };


    // Return this to ensure chainability
    return this.each(function() {
      var $this = $(this);
    });
  };
})( jQuery );