import $ from 'jquery'
import 'quote_slider'

window.setupHomepage = function() {
  $('.hero').addClass('peptalk-is-visible');
  $('.sliding_quotes').quoteSlider();
}
