data = [[
  'Date',
  'Start time',
  'End time',
  'Duration',
  'Text'
]]
elements = document.querySelectorAll('.L1Ysrb')
Array.prototype.forEach.call elements, (el) ->
  times = el.querySelector('.vXnnM').textContent.split(' – ')
  data.push [
    el.querySelector('.mAvCFe').textContent,
    times[0],
    times[1],
    Math.abs(new Date("2000-01-01T#{times[0]}") - new Date("2000-01-01T#{times[1]}")) / 36e5;
    el.querySelector('html-blob').textContent
  ]
csv = data.map((value) -> value.join(',')).join("\n")

textArea = document.createElement('textarea')
textArea.value = csv
document.body.appendChild(textArea)
textArea.select()
document.execCommand('copy')
document.body.removeChild(textArea)
