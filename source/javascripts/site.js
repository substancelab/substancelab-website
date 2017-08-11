import 'quote_slider'
// require 'ensure_equal_heights.js'

window.setupHomepage = function() {
  console.debug('Setup homepage')
  $('.sliding_quotes').quoteSlider();
  // $(['.featured-work .tile', '.article-list .tile']).adjustEqualHeights();
}
