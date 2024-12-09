// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// Ensure the UJS library is loaded for handling method: :delete
import "@rails/ujs"
import "../stylesheets/application";
import Turbolinks from "turbolinks"
import "channels"
import * as ActiveStorage from "@rails/activestorage"
import "@hotwired/turbo-rails";
import Rails from "@rails/ujs"

// Rails関連の初期化
// ここはWebpackerによって読み込まれるエントリーポイント
Turbolinks.start()
Rails.start();
ActiveStorage.start();

// Turbo submit中のボタン無効化などのDOM操作イベント
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

// サイドバー開閉処理（DOM操作）
document.addEventListener('DOMContentLoaded', () => {
  const sidebar = document.getElementById('sidebar');
  const toggleOpen = document.querySelector('.toggle-sidebar_open');
  const toggleClose = document.querySelector('.toggle-sidebar_close');
  const toggleSidebar = document.getElementById('toggle-sidebar');
  
  if (toggleSidebar) {
    toggleSidebar.addEventListener('click', function() {
      if (!sidebar) return;
      sidebar.style.display = (sidebar.style.display === 'block') ? 'none' : 'block';
    });
  }
  if (toggleClose) {
    toggleClose.addEventListener('click', function() {
      if (!sidebar || !toggleOpen || !toggleClose) return;
      sidebar.style.display = 'none';
      toggleClose.style.display = 'none';
      toggleOpen.style.display = 'inline-block';
    });
  }
  if (toggleOpen) {
    toggleOpen.addEventListener('click', function() {
      if (!sidebar || !toggleOpen || !toggleClose) return;
      sidebar.style.display = 'block';
      toggleClose.style.display = 'inline-block';
      toggleOpen.style.display = 'none';
    });
  }
});
