(function() {
  var textarea;

  textarea = document.createElement('textarea');

  textarea.textContent = window.location.toString().split('?')[0];

  document.body.appendChild(textarea);

  textarea.select();

  try {
    if (!document.execCommand('copy')) {
      alert('Could not copy URL.');
    }
  } catch (error) {
    alert('Could not copy URL.');
  }

  document.body.removeChild(textarea);

}).call(this);
