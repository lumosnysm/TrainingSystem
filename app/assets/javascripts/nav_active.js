$(document).ready(function () {
  var url = window.location;
  $('ul.nav li a').each(function () {
    if (this.href == url) {
      $("ul.nav li").each(function () {
        if ($(this).hasClass("active")) {
          $(this).removeClass("active");
        }
      });
      $(this).parents().addClass('active');
    }
  });
});
