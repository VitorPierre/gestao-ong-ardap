import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { type: String }

  connect() {
    this.element.addEventListener('input', this.format.bind(this))
    this.format() // Format initial value
  }

  disconnect() {
    this.element.removeEventListener('input', this.format.bind(this))
  }

  format() {
    let value = this.element.value

    if (this.typeValue === 'cpf') {
      value = value.replace(/\D/g, '')
                   .replace(/(\d{3})(\d)/, '$1.$2')
                   .replace(/(\d{3})(\d)/, '$1.$2')
                   .replace(/(\d{3})(\d{1,2})/, '$1-$2')
                   .replace(/(-\d{2})\d+?$/, '$1')
    } else if (this.typeValue === 'cnpj') {
      value = value.replace(/\D/g, '')
                   .replace(/(\d{2})(\d)/, '$1.$2')
                   .replace(/(\d{3})(\d)/, '$1.$2')
                   .replace(/(\d{3})(\d)/, '$1/$2')
                   .replace(/(\d{4})(\d{1,2})/, '$1-$2')
                   .replace(/(-\d{2})\d+?$/, '$1')
    } else if (this.typeValue === 'phone') {
      value = value.replace(/\D/g, '')
      if (value.length > 10) {
        value = value.replace(/^(\d{2})(\d{5})(\d{4}).*/, '($1) $2-$3')
      } else if (value.length > 6) {
        value = value.replace(/^(\d{2})(\d{4})(\d{0,4}).*/, '($1) $2-$3')
      } else if (value.length > 2) {
        value = value.replace(/^(\d{2})(\d{0,5})/, '($1) $2')
      } else if (value.length > 0) {
        value = value.replace(/^(\d*)/, '($1')
      }
    } else if (this.typeValue === 'cep') {
      value = value.replace(/\D/g, '')
                   .replace(/(\d{5})(\d{1,3})/, '$1-$2')
                   .replace(/(-\d{3})\d+?$/, '$1')
    }

    this.element.value = value
  }
}
