data = [[
  'Date',
  'Start time',
  'End time',
  'Duration',
  'Text'
]]
wrapperElements = document.querySelectorAll('.L1Ysrb')
Array.prototype.forEach.call wrapperElements, (wrapperElement) ->
  timeElements = wrapperElement.querySelectorAll('.vXnnM')
  date = wrapperElement.querySelector('.mAvCFe').textContent
  text = wrapperElement.querySelector('html-blob').textContent
  Array.prototype.forEach.call timeElements, (timeElement) ->
    times = timeElement.textContent.split(' – ')
    data.push [
      date,
      times[0],
      times[1],
      Math.abs(new Date("2000-01-01T#{times[0]}") - new Date("2000-01-01T#{times[1]}")) / 36e5;
      text
    ]
csv = data.map((value) -> value.join(',')).join("\n")

textArea = document.createElement('textarea')
textArea.value = csv
document.body.appendChild(textArea)
textArea.select()
document.execCommand('copy')
document.body.removeChild(textArea)
