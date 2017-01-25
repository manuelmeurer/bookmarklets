(function() {
  $('.search-result').each(function(i, el) {
    var path, url;
    path = $('.name-page-link', el).attr('href').match(/\/profile\/[0-9A-Za-z_]+/);
    url = window.location.origin + path;
    return window.open(url);
  });

}).call(this);
