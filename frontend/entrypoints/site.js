import $ from 'jquery'
import '../quote_slider'

$(function() {
  if ($('.sliding_quotes').length) {
    $('.hero').addClass('peptalk-is-visible');
    $('.sliding_quotes').quoteSlider();
  }
})
