import { Controller } from "stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  static targets = ["details"]

  show(event) {
    const resourceId = event.currentTarget.getAttribute("data-resource-id")

    fetch(`/resources/${resourceId}`)
      .then(response => response.text())
      .then(html => {
        this.detailsTarget.innerHTML = html
      })
  }

  complete(event) {
    const resourceId = this.detailsTarget.querySelector("#complete-button").getAttribute("data-resource-id")

    fetch(`/resources/${resourceId}/complete`, { method: "POST" })
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok')
        }
        return response.text()
      })
      .then(() => {
        alert("Ressource marquée comme complétée!")
        Turbo.visit(window.location.href)
      })
      .catch(error => {
        console.error('There was a problem with the fetch operation:', error)
      })
  }
}
