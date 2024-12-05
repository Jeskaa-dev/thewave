import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["paragraph", "image", "audioIcon"];
  static values = { images: Array, redirectUrl: String };

  connect() {
    this.currentParagraph = 0;
    this.audioElement = document.getElementById("background-audio");
    this.transitionAudio = new Audio(
      "https://res.cloudinary.com/dxqaj3mdo/video/upload/v1733390297/qwhk4pgwayryb43z7k2z.mp3"
    );
    this.startTextAnimation(this.currentParagraph);
  }

  typeWriter(text, i, fnCallback) {
    const paragraph = this.paragraphTargets[this.currentParagraph];

    if (i < text.length) {
      paragraph.innerHTML =
        text.substring(0, i + 1) + '<span aria-hidden="true"></span>';
      setTimeout(() => {
        this.typeWriter(text, i + 1, fnCallback);
      }, 50);
    } else if (typeof fnCallback === "function") {
      setTimeout(fnCallback, 700);
    }
  }

  startTextAnimation(i) {
    if (i < this.paragraphTargets.length) {
      const paragraph = this.paragraphTargets[i];
      const imageUrl = this.imagesValue[i];

      paragraph.classList.remove("hidden");
      this.typeWriter(paragraph.textContent, 0, () => {
        this.currentParagraph++;
        if (imageUrl) {
          this.imageTarget.src = imageUrl;
          this.imageTarget.classList.remove("hidden");
        }
        this.startTextAnimation(this.currentParagraph);
      });
    }
  }

  toggleAudio() {
    const audioIcon = this.audioIconTarget;

    if (this.audioElement.paused) {
      this.audioElement.play();
      audioIcon.classList.remove("fa-volume-xmark");
      audioIcon.classList.add("fa-volume-off");
    } else {
      this.audioElement.pause();
      audioIcon.classList.remove("fa-volume-off");
      audioIcon.classList.add("fa-volume-xmark");
    }
  }

  stopAudioAndRedirect(event) {
    event.preventDefault(); // Empêche la redirection immédiate

    const redirectUrl = this.redirectUrlValue; // Utilise la valeur de redirection depuis Stimulus

    // Arrêter l'audio actuel s'il est en cours de lecture
    if (this.audioElement && !this.audioElement.paused) {
      this.audioElement.pause();
    }

    // Ajouter un délai maximum pour rediriger même si onended n'est pas appelé
    const redirectFallback = setTimeout(() => {
      console.log("Fallback redirect triggered...");
      window.location.href = redirectUrl;
    }, 5000); // 5 secondes, durée approximative du son de transition

    // Jouer le son de transition
    this.transitionAudio.play().then(() => {
      console.log("Transition audio playing...");
    }).catch((error) => {
      console.error("Error playing transition audio:", error);
      // Redirige immédiatement si une erreur empêche le son de jouer
      clearTimeout(redirectFallback); // Annule le fallback
      window.location.href = redirectUrl;
    });

    // Une fois le son terminé, effectuer la redirection
    this.transitionAudio.onended = () => {
      console.log("Transition audio ended, redirecting...");
      clearTimeout(redirectFallback); // Annule le fallback
      window.location.href = redirectUrl; // Redirige vers l'URL de redirection
    };
  }
}
