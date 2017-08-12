textarea = document.createElement('textarea')
textarea.textContent = window.location.toString().split('?')[0]
document.body.appendChild(textarea)
textarea.select()

try
  unless document.execCommand('copy')
    alert 'Could not copy URL.'
catch
  alert 'Could not copy URL.'

document.body.removeChild(textarea)
