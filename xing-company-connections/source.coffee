# Scroll all the way down so all contacts are loaded.
interval =
  setInterval ->
    if $('footer')[0].getBoundingClientRect().top > window.innerHeight
      window.scrollBy(0, window.innerHeight)
    else
      clearInterval(interval)
      $(window).scrollTop(0)
      sortContacts()
  , 500

sortContacts = ->
  $contacts = $('.contact')
  $contacts.detach()
  $pages = $('.page')
  $pages.not(":eq(0)").remove()
  $firstPage = $pages.first()
  $firstPage.empty()

  $.each $contacts, (i, el) ->
    $el = $(el)
    path = $el.find('.user-name-link').attr('href')
    name = path.match(/profile\/(\w+)/)[1]
    url = "https://www.xing.com/app/contact?op=showroutes;name=#{name}"

    $.get url, (data) ->
      $doc = $($.parseHTML(data))
      $connectionList = $doc.find('.contact-path-list')
      connections = $connectionList.length
      hops = if connections > 0
        $connectionList.filter(':first').find('li').length - 2
      else
        99

      html = "<div style='position:absolute;top:0;right:0;'><a href='#{url}'>"
      if hops != 99
        html += "#{hops} hop#{if hops == 1 then '' else 's'}<br>"
      html += "#{connections} connection#{if connections == 1 then '' else 's'}</a></div>"
      $el.find('.component-user-card').append(html)

      $el.data('connections', connections)
      $el.data('hops', hops)

      if hops != 99
        $contactsWithMoreHops = $firstPage.find('.contact').filter (i, el) ->
          $(el).data('hops') > hops
        if $contactsWithMoreHops.length
          $contactsWithMoreHops.first().before($el)

      unless $firstPage.has($el).length
        $firstPage.append($el)
