//= require jquery.equalheights.min.js

function adjustEqualHeights(selectorsToAdjust) {
 
  $(document).ready(function() {
    adjustOnAction(selectorsToAdjust);
  });
  $( window ).resize(function() {
    adjustOnAction(selectorsToAdjust);
  });
}

function adjustOnAction(contentToAdjust) {
   for(var i=0; i < contentToAdjust.length; i++) {
    $(contentToAdjust[i]).css({height: ""}).equalHeights();
  }
}
