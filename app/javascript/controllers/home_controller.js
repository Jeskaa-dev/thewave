document.addEventListener('DOMContentLoaded', function () {
  const paragraphs = document.querySelectorAll('#text-container p');
  const images = [
    '<%= asset_path("/app/assets/images/mascot1.png") %>',
    '<%= asset_path("/app/assets/images/mascot2.png") %>',
    '<%= asset_path("/app/assets/images/mascot3.png") %>',
    '<%= asset_path("/app/assets/images/mascot4.png") %>',
    '<%= asset_path("/app/assets/images/mascot5.png") %>',
    '<%= asset_path("/app/assets/images/mascot6.png") %>',
    // Ajoutez d'autres chemins d'images ici
  ];
  const imageElement = document.getElementById('current-image');
  let currentParagraph = 0;

  function typeWriter(text, i, fnCallback) {
    if (i < text.length) {
      paragraphs[currentParagraph].innerHTML = text.substring(0, i + 1) + '<span aria-hidden="true"></span>';
      setTimeout(function () {
        typeWriter(text, i + 1, fnCallback);
      }, 50);
    } else if (typeof fnCallback == 'function') {
      setTimeout(fnCallback, 700);
    }
  }

  function startTextAnimation(i) {
    if (i < paragraphs.length) {
      paragraphs[i].classList.remove('hidden');
      typeWriter(paragraphs[i].textContent, 0, function () {
        currentParagraph++;
        if (i < images.length) {
          imageElement.src = images[i];
          imageElement.classList.remove('hidden');
        }
        startTextAnimation(i + 1);
      });
    }
  }

  startTextAnimation(currentParagraph);
});
