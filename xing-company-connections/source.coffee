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
    url = "https://www.xing.com/app/contact?op=showroutesname=#{name}"

    $.get url, (data) ->
      $doc = $($.parseHTML(data))
      $connectionList = $doc.find('.contact-path-list')
      connections = $connectionList.length
      if connections > 0
        hops = $connectionList.filter(':first').find('li').length - 2

      html = "<div style='position:absolutetop:0right:0'><a href='#{url}'>"
      if hops
        html += "#{hops} hop#{'s' unless hops == 1}<br>"
      html += "#{connections} connection#{'s' unless connections == 1}</a></div>"
      $el.find('.component-user-card').append(html)

      $el.data('connections', connections)

      if hops
        $el.data('hops', hops)
        $contactsWithMoreHops = $firstPage.find('.contact').filter (i, el) ->
          ($(el).data('hops') || 0) > hops
        if $contactsWithMoreHops.length
          $contactsWithMoreHops.first().before($el)

      unless $firstPage.has($el).length
        $firstPage.append($el)
