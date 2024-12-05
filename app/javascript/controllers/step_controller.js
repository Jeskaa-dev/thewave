

import { Controller } from "@hotwired/stimulus";
// Connects to data-controller="step"

export default class extends Controller {
  static targets = ["input", "stepContainer"];

  connect() {

    console.log("Hello, Stimulus!");
  }

  validateInputs() {
      // Vérifie si tous les champs contiennent une URL valide
      this.stepContainerTargets.forEach((container, index) => {
        const inputs = this.inputTargets.slice(index * 2, (index + 1) * 2); // Sélectionne les deux inputs pour chaque step
        const allValid = inputs.every(input => this.isValidURL(input.value));

        if (allValid) {
          container.classList.add("timeline-done");
          container.classList.remove("timeline");
        } else {
          container.classList.add("timeline");
          container.classList.remove("timeline-done");
        }
      });
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
