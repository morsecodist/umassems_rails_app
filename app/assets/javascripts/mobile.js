//= require jquery
//= require jquery_ujs
//= require jquery.mmenu.min.js
//= require jquery.mobile

/*global $*/

var menu = function () {
    'use strict';
    $("#main_menu").mmenu({
    }, {});
};

$(document).on('ready', menu);

//This is a monstrosity forced upon me by my lack of understanding of jquery mobile
$(document).on('click', 'a:not(mobile_menu_open)', function () {
    'use strict';
    location.replace(this.attr('href'));
});

$(document).on('swiperight', function () {
    'use strict';
    $("#main_menu").data('mmenu').open();
});