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
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        // Update checkbox
        event.target.disabled = true
        event.target.textContent = 'Complété!'

    // Find checkbox in the resource list and update it
    const resourceItem = document.querySelector(`[data-resource-id="${resourceId}"]`);
    if (resourceItem) {
      const checkbox = resourceItem.querySelector('input[type="checkbox"]');
      if (checkbox) {
        checkbox.checked = true;
      }
    }

        // Update skill proficiency display
        const skillItem = document.querySelector(`[data-skill-id="${data.skill_id}"]`);
        if (skillItem) {
          skillItem.style.setProperty('--rating', `${data.new_rating}%`);
        }

        // Refresh the page to update all proficiency displays
        Turbo.visit(window.location.href)
      }
    })
    .catch(error => console.error('Error:', error))
  }
}
