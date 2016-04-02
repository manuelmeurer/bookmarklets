initGallery = (images) ->
  $container = $('.biga-entries').empty()
  $gallery = $('<div class="fotorama" data-nav="thumbs" data-navposition="top" data-keyboard="true" data-trackpad="true" data-loop="true" data-auto="false"></div>').appendTo($container)
  $text = $('<div id="fotorama-text" style="margin-top: 10px"></div>').appendTo($container)
  images.sort (a, b) ->
    a[0] - b[0]
  for image in images
    $gallery.append("<img src='#{image[1]}'>")
  $gallery
    .on 'fotorama:show', (e, fotorama) ->
      $text.html images[fotorama.activeFrame.i - 1][2]
    .fotorama()

$ ->
  script = document.createElement('script')
  script.src = 'http://cdnjs.cloudflare.com/ajax/libs/fotorama/4.6.4/fotorama.js'
  script.async = false
  document.head.appendChild(script)
  $('head').append('<link href="http://cdnjs.cloudflare.com/ajax/libs/fotorama/4.6.4/fotorama.css" rel="stylesheet">')
  maxPage = parseInt($('.biga-control > span').get(0).innerText.match(/von\s+(\d+)/)[1])
  page = 1
  images = []
  while page <= maxPage
    suffix = if page == 1 then '' else "-#{page}"
    url = window.location.href.replace(/(?:-\d{1,2})?\.html$/, "#{suffix}.html")
    $.get url, (data) ->
      $doc  = $($.parseHTML(data))
      $imageWrapper = $doc.find('.biga-image')
      fetchedPage = parseInt(@url.match(/(?:-(\d{1,2}))?\.html$/)[1] || '1')
      image = $imageWrapper.find('img').attr('src')
      text  = $imageWrapper.find('+ p').html()
      images.push [fetchedPage, image, text]
      initGallery images if images.length == maxPage
    page++
