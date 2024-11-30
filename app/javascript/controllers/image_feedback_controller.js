import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["fileInput", "feedback"];

  connect() {
    console.log("Image feedback controller connected");
  }

  change() {
    if (this.fileInputTarget.files.length > 0) {
      // Actualizar el texto del feedback con el nombre del archivo seleccionado
      this.feedbackTarget.textContent = "Image ready to publish: " + this.fileInputTarget.files[0].name;
      this.feedbackTarget.style.color = "green";
    } else {
      // Si no hay archivo seleccionado, mostrar mensaje predeterminado
      this.feedbackTarget.textContent = "No file chosen";
      this.feedbackTarget.style.color = "red";
    }
  }
}
