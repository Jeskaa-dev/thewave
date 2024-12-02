import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  static targets = ["rotate", "hiddenList", "subRotate", "subHiddenList"];
  connect() {
    console.log("List controller is working!");
  }
  display(event) {
    console.log("Event triggered:", event.currentTarget); // Vérifie l'élément déclencheur
  console.log("Rotate targets:", this.rotateTargets);  // Vérifie les cibles définies
  console.log("Hidden list targets:", this.hiddenListTargets); // Vérifie les listes cachées

    // Récupère l'élément déclencheur
    const button = event.currentTarget;

    // // Cible la liste associée (basée sur l'ordre ou autre logique)
    const listIndex = this.rotateTargets.indexOf(button);
    const hiddenList = this.hiddenListTargets[listIndex];

    // // Toggle la classe "hidden" sur la liste associée
    if (hiddenList) {
      hiddenList.classList.toggle("hidden");
    }

    // // Gère la rotation de l'icône
    button.classList.toggle("rotate-90");
  }

  subDisplay(event) {
      // Récupère l'élément déclencheur
      const button = event.currentTarget;

      // // Cible la liste associée (basée sur l'ordre ou autre logique)
      const listIndex = this.subRotateTargets.indexOf(button);
      const hiddenList = this.subHiddenListTargets[listIndex];

      // // Toggle la classe "hidden" sur la liste associée
      if (hiddenList) {
        hiddenList.classList.toggle("hidden");
      }

      // // Gère la rotation de l'icône
      button.classList.toggle("rotate-90");
  }

}
