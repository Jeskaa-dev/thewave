

import { Controller } from "@hotwired/stimulus";
// Connects to data-controller="step"

export default class extends Controller {
  static targets = ["input", "stepContainer"];

  connect() {

    console.log("Hello, Stimulus!");
  }

  validateInputs() {
    // Vérifie si tous les champs contiennent une URL valide
    const allValid = this.inputTargets.every(input => this.isValidURL(input.value));

    // Ajoute ou supprime une classe en fonction de la validation
    if (allValid) {
      this.stepContainerTarget.classList.add("timeline-done");
      this.stepContainerTarget.classList.remove("timeline");
    } else {
      this.stepContainerTarget.classList.add("timeline");
      this.stepContainerTarget.classList.remove("timeline-done");
    }
  }

  isValidURL(value) {
    try {
      new URL(value); // Valide si c'est une URL
      return true;
    } catch {
      return false;
    }
  }
}
