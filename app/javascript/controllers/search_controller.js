import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'searchForm',
    'searchField',
    'submitButton',
    'searchPreview',
  ];

  initialize() {
    console.log('initialize');
  }

  connect() {
    console.log('connect');
  }

  searchPreviewTargetConnected() {
    if (this.searchFieldTarget.value.length >= 3) {
      const link = document.createElement('a');

      link.href =
        this.searchFormTarget.action +
        '?search=' +
        this.searchFieldTarget.value;

      link.innerText = 'Смотреть все';

      this.searchPreviewTarget.appendChild(link);
    }
  }

  getData() {
    if (this.searchFieldTarget.value.length >= 3) {
      this.submitButtonTarget.click();
    } else {
      this.searchPreviewTarget.innerHTML = '';
    }
  }
}
