import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="completion"
export default class extends Controller {
  connect() {
    console.log("Hello you !!")
  }
}
