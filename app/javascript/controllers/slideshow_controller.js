import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static values = { index: Number };
  static targets = ['slide'];

  initialize() {
    // console.log('initialize');
    // this.index = 0;
    // this.index = Number(this.element.dataset.index);
    this.index = this.indexValue;
    console.log(typeof this.indexValue);
    this.showCurrentSlide();
  }

  // connect() {
  //   // this.element.textContent = "Hello World!"
  //   console.log('connect');
  // }

  next() {
    // this.index++;
    this.indexValue++;
    // this.showCurrentSlide();
  }

  previous() {
    // this.index--;
    this.indexValue--;
    // this.showCurrentSlide();
  }

  indexValueChanged() {
    this.showCurrentSlide();
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index !== this.indexValue;

      // if (index == this.index) {
      //   element.hidden = false;
      // } else {
      //   element.hidden = true;
      // }
    });
  }
}
