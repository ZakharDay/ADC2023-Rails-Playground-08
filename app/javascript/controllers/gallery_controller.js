import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'newImageButton',
    'createImageButton',
    'galleryImagesRail',
    'galleryImage',
    'prevButton',
    'nextButton',
  ];

  // initialize() {
  // console.log('initialize');
  // }

  connect() {
    //   console.log('connect');
    this.index = 0;
    this.renderNavigation();
  }

  newImage() {
    this.newImageButtonTarget.click();
  }

  createImage() {
    this.createImageButtonTarget.click();
  }

  prevImage() {
    this.moveSlide('prev');
  }

  nextImage() {
    this.moveSlide('next');
  }

  renderNavigation() {
    if (this.index === 0) {
      this.prevButtonTarget.style.display = 'none';
    }

    if (this.index > 0) {
      this.prevButtonTarget.style.display = 'block';
    }

    if (this.index + 1 < this.galleryImageTargets.length) {
      this.nextButtonTarget.style.display = 'block';
    }

    if (this.index + 1 >= this.galleryImageTargets.length) {
      this.nextButtonTarget.style.display = 'none';
    }
  }

  moveSlide(direction) {
    if (direction === 'prev') {
      if (this.index >= 1) {
        this.index -= 1;
      }
    } else if (direction === 'next') {
      if (this.index + 1 < this.galleryImageTargets.length) {
        this.index += 1;
      }
    }

    this.galleryImagesRailTarget.style.transform = `translateX(-${
      100 * this.index
    }%)`;

    this.renderNavigation();
  }

  // deleteImage() {

  // }
}
