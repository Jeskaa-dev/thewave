import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { redirectUrl: String };

  connect() {
    // Précharge l'audio de transition
    this.transitionAudio = new Audio(
      "https://res.cloudinary.com/dxqaj3mdo/video/upload/v1733390297/qwhk4pgwayryb43z7k2z.mp3"
    );
  }

  playSoundAndRedirect(event) {
    event.preventDefault(); // Empêche la redirection immédiate

    const redirectUrl = this.redirectUrlValue; // Récupère l'URL de redirection depuis Stimulus

    // Jouer le son de transition
    this.transitionAudio.play().then(() => {
      console.log("Transition audio playing...");
    }).catch((error) => {
      console.error("Error playing transition audio:", error);
      // Redirige immédiatement si le son échoue à jouer
      window.location.href = redirectUrl;
    });

    // Redirige à la fin du son
    this.transitionAudio.onended = () => {
      console.log("Transition audio ended, redirecting...");
      window.location.href = redirectUrl;
    };
  }
}
