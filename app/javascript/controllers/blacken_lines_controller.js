import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="blacken-lines"
export default class extends Controller {
  static targets = ["line"];
  static values = {
    characterName: String
  };

  connect() {
    console.log(this.characterNameValue)
    // Black out all lines for the specified character on page load
    this.lineTargets.forEach((line) => {
      if (line.dataset.character === this.characterNameValue) {
        line.classList.add("blacked-out");
      }
    });
  }

  toggle(event) {
    const line = event.currentTarget;
    if (line.dataset.character === this.characterNameValue) {
      line.classList.toggle("blacked-out");
    }
  }
}
