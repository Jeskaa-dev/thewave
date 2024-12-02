import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("List controller is working!");
  }
}


  // display(event) {
  //   // Récupère l'élément déclencheur
  //   const button = event.currentTarget;

  //   // Cible la liste associée (basée sur l'ordre ou autre logique)
  //   const listIndex = this.rotateTargets.indexOf(button);
  //   const hiddenList = this.hiddenListTargets[listIndex];

  //   // Toggle la classe "hidden" sur la liste associée
  //   if (hiddenList) {
  //     hiddenList.classList.toggle("hidden");
  //   }

  //   // Gère la rotation de l'icône
  //   button.classList.toggle("rotate-90");
  // }
