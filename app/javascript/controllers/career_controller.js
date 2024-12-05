
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox"]

  toggle(event) {
    const program = event.target.value
    const checked = event.target.checked

    // Uncheck other checkboxes
    this.checkboxTargets.forEach(checkbox => {
      if (checkbox !== event.target) {
        checkbox.checked = false
      }
    })

    fetch('/users/update_career', {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({
        career_program: checked ? program : null
      })
    })
  }
}
