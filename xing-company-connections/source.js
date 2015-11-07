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
      url = "https://www.xing.com/app/contact?op=showroutes;name=" + name;
      return $.get(url, function(data) {
        var $connectionList, $contactsWithMoreHops, $doc, connections, hops, html;
        $doc = $($.parseHTML(data));
        $connectionList = $doc.find('.contact-path-list');
        connections = $connectionList.length;
        hops = connections > 0 ? $connectionList.filter(':first').find('li').length - 2 : 99;
        html = "<div style='position:absolute;top:0;right:0;'><a href='" + url + "'>";
        if (hops !== 99) {
          html += hops + " hop" + (hops === 1 ? '' : 's') + "<br>";
        }
        html += connections + " connection" + (connections === 1 ? '' : 's') + "</a></div>";
        $el.find('.component-user-card').append(html);
        $el.data('connections', connections);
        $el.data('hops', hops);
        if (hops !== 99) {
          $contactsWithMoreHops = $firstPage.find('.contact').filter(function(i, el) {
            return $(el).data('hops') > hops;
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
