import { Controller } from "@hotwired/stimulus"

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
