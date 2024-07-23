import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="priority"
export default class extends Controller {
  static targets = ['currentPriority', 'priorityLabel']

  changePriorityLabel() {
    this.priorityLabelTarget.classList.forEach(className => {
      if (/priority/.test(className)) {
        this.priorityLabelTarget.classList.remove(className);
      }
    });

    this.priorityLabelTarget.classList.add(`priority-${this.currentPriorityTarget.value}`);
  }
}
