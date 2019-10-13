const re = /^[0-9.,]+$/;

var checkIfExists = setInterval(function() {
  var exists = document.querySelector(".smart-table-data-cell");

  if (exists) {
    document.querySelectorAll('.smart-table-data-cell').forEach(function(cell) {
      if (re.test(cell.textContent)) {
        cell.textContent = cell.textContent.replace(/\,/g,'')
      }
    })
  }
}, 25);

