// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"

Rails.start()
ActiveStorage.start()

document.addEventListener("turbo:submit-start", function(event) {
  const button = event.target.querySelector("input[type='submit']");
  if (button) button.disabled = true;
});

document.addEventListener("turbo:submit-end", function(event) {
  if (event.detail.success === false) {
    const button = event.target.querySelector("input[type='submit']");
    if (button) button.disabled = false;
  }
});

