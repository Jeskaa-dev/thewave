import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { audioUrl: String };
  static targets = ["audioIcon"];

  connect() {
    console.log("GlobalAudioController connected");

    // Initialise l'audio sans préchargement automatique
    this.audioElement = new Audio(this.audioUrlValue);
    this.audioElement.preload = "none"; // Désactive le préchargement
    this.audioElement.loop = true;

    // Vérifie si l'audio était en cours de lecture
    if (localStorage.getItem("audioPlaying") === "true") {
      console.log("Audio was playing, attempting to start...");
      this.playAudio();
    }
  }

  toggleAudio() {
    console.log("Toggle audio called");
    if (this.audioElement.paused) {
      this.playAudio();
    } else {
      this.pauseAudio();
    }
  }

  playAudio() {
    console.log("Play audio called");
    this.audioElement.play().then(() => {
      console.log("Audio playback started");
    }).catch((error) => {
      console.error("Audio playback failed:", error);
    });
    this.updateIcon(true);
    localStorage.setItem("audioPlaying", "true");
  }

  pauseAudio() {
    console.log("Pause audio called");
    this.audioElement.pause();
    this.updateIcon(false);
    localStorage.setItem("audioPlaying", "false");
  }

  updateIcon(isPlaying) {
    console.log("Updating icon:", isPlaying);
    if (this.hasAudioIconTarget) {
      this.audioIconTarget.classList.toggle("fa-volume-off", isPlaying);
      this.audioIconTarget.classList.toggle("fa-volume-xmark", !isPlaying);
    }
  }
}
