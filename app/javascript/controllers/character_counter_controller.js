import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "counter"]

  connect() {
    this.updateCounter()
    this.inputTarget.addEventListener("input", this.updateCounter.bind(this))
  }

  disconnect() {
    this.inputTarget.removeEventListener("input", this.updateCounter.bind(this))
  }

  updateCounter() {
    const maxLength = this.inputTarget.getAttribute("maxlength")
    if (!maxLength) return

    const currentLength = this.inputTarget.value.length
    this.counterTarget.textContent = `${currentLength} / ${maxLength} caracteres`
    
    if (currentLength >= maxLength) {
      this.counterTarget.classList.add("text-red-500", "font-bold")
      this.counterTarget.classList.remove("text-gray-500")
    } else {
      this.counterTarget.classList.remove("text-red-500", "font-bold")
      this.counterTarget.classList.add("text-gray-500")
    }
  }
}
