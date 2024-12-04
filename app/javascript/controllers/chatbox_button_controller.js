import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chatbox-button"
export default class extends Controller {
  static targets = ["modal"]

  connect() {
    console.log("Chatbot button controller connected")
  }

  toggle() {
    const chatModal = document.querySelector('[data-chatbot-target="modal"]')
    if (chatModal) { chatModal.classList.toggle('hidden') }
  }
}
