import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="resource"
export default class extends Controller {
  static targets = ["details"]

  connect() {
    console.log("Resource controller connected")
  }

  show(event) {
    const resourceId = event.currentTarget.dataset.resourceId

    fetch(`/resources/${resourceId}`, {
      headers: {
        'Accept': 'text/html',
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
    .then(response => response.text())
    .then(html => {
      this.detailsTarget.innerHTML = html
    })
    .catch(error => {
      console.error('Error:', error)
    })
    this.element.querySelectorAll('.resource-item').forEach(item => {
      item.classList.remove('active')
    })

    // Add active class to clicked item
    event.currentTarget.classList.add('active')

    
    fetch(`/resources/${resourceId}`, {
      headers: {
        'Accept': 'text/html',
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
    .then(response => response.text())
    .then(html => {
      this.detailsTarget.innerHTML = html
    })
  }

  complete(event) {
    const button = event.currentTarget
    const resourceId = button.dataset.resourceId
    const token = document.querySelector('meta[name="csrf-token"]').content

    fetch(`/resources/${resourceId}/complete`, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': token,
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    })
    .then(response => {
      if (!response.ok) throw new Error('Network response was not ok')
      button.textContent = 'Complété!'
      button.disabled = true
      const checkbox = document.querySelector(`[data-resource-id="${resourceId}"] input[type="checkbox"]`)
      if (checkbox) checkbox.checked = true
    })
    .catch(error => {
      console.error('Error:', error)
    })
  }
}
