document.addEventListener('DOMContentLoaded', function () {
  const paragraphs = document.querySelectorAll('#text-container p');
  const images = [
    'https://res.cloudinary.com/dxqaj3mdo/image/upload/v1733318898/w5cep9i8saecicddxv65.png',
    'https://res.cloudinary.com/dxqaj3mdo/image/upload/v1733318898/drppcbyvo8t3fdw3wqpv.png',
    'https://res.cloudinary.com/dxqaj3mdo/image/upload/v1733318898/kllkx6lax4q3m8uptkeo.png',
    'https://res.cloudinary.com/dxqaj3mdo/image/upload/v1733318898/drppcbyvo8t3fdw3wqpv.png',
    'https://res.cloudinary.com/dxqaj3mdo/image/upload/v1733318898/xykbkgqtyllaqgwfkky6.png',
  ];
  const imageElement = document.getElementById('current-image');
  let currentParagraph = 0;

  function typeWriter(text, i, fnCallback) {
    if (i < text.length) {
      paragraphs[currentParagraph].innerHTML = text.substring(0, i + 1) + '<span aria-hidden="true"></span>';
      setTimeout(function () {
        typeWriter(text, i + 1, fnCallback);
      }, 50);
    } else if (typeof fnCallback === 'function') {
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
