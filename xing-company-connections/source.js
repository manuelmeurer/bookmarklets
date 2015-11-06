(function() {
  var interval, sortContacts;

  interval = setInterval(function() {
    if ($('footer')[0].getBoundingClientRect().top > window.innerHeight) {
      return window.scrollBy(0, window.innerHeight);
    } else {
      clearInterval(interval);
      $(window).scrollTop(0);
      return sortContacts();
    }
  }, 500);

  sortContacts = function() {
    var $contacts, $firstPage, $pages;
    $contacts = $('.contact');
    $contacts.detach();
    $pages = $('.page');
    $pages.not(":eq(0)").remove();
    $firstPage = $pages.first();
    $firstPage.empty();
    return $.each($contacts, function(i, el) {
      var $el, name, path, url;
      $el = $(el);
      path = $el.find('.user-name-link').attr('href');
      name = path.match(/profile\/(\w+)/)[1];
      url = "https://www.xing.com/app/contact?op=showroutesname=" + name;
      return $.get(url, function(data) {
        var $connectionList, $contactsWithMoreHops, $doc, connections, hops, html;
        $doc = $($.parseHTML(data));
        $connectionList = $doc.find('.contact-path-list');
        connections = $connectionList.length;
        if (connections > 0) {
          hops = $connectionList.filter(':first').find('li').length - 2;
        }
        html = "<div style='position:absolutetop:0right:0'><a href='" + url + "'>";
        if (hops) {
          html += hops + " hop" + (hops !== 1 ? 's' : void 0) + "<br>";
        }
        html += connections + " connection" + (connections !== 1 ? 's' : void 0) + "</a></div>";
        $el.find('.component-user-card').append(html);
        $el.data('connections', connections);
        if (hops) {
          $el.data('hops', hops);
          $contactsWithMoreHops = $firstPage.find('.contact').filter(function(i, el) {
            return ($(el).data('hops') || 0) > hops;
          });
          if ($contactsWithMoreHops.length) {
            $contactsWithMoreHops.first().before($el);
          }
        }
        if (!$firstPage.has($el).length) {
          return $firstPage.append($el);
        }
      });
    });
  };

}).call(this);
