document.addEventListener("DOMContentLoaded", function() {
    var fileInput = document.getElementById("tweeet_image");
    var fileFeedback = document.getElementById("file-feedback");
  
    if (fileInput) {
      fileInput.addEventListener("change", function() {
        if (fileInput.files.length > 0) {
          // Actualizar el texto del feedback con el nombre del archivo seleccionado
          fileFeedback.textContent = "Image ready to publish: " + fileInput.files[0].name;
          fileFeedback.style.color = "green"; // Cambiar el color a verde para indicar que está listo
        } else {
          // Si no hay archivo seleccionado, mostrar mensaje predeterminado
          fileFeedback.textContent = "No file chosen";
          fileFeedback.style.color = "red"; // Opcionalmente, cambiar el color a rojo
        }
      });
    }
  });