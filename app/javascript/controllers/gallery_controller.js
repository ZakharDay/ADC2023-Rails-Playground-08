import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'newImageButton',
    'newImageForm',
    'createImageButton',
    'galleryImagesRail',
    'galleryImage',
    'prevButton',
    'nextButton',
    'galleryMeatballs',
    'galleryMeatball',
  ];

  static classes = ['current'];

  // initialize() {
  // console.log('initialize');
  // }

  connect() {
    console.log('connect');
    this.index = 0;

    if (this.galleryImageTargets.length) {
      this.renderNavigation();
      this.renderMeatballs();
    }
  }

  galleryImagesRailTargetConnected() {
    console.log('galleryImagesRailTargetConnected');
    this.renderSlides();
  }

  galleryImageTargetConnected() {
    console.log('galleryImageTargetConnected');
    this.renderNavigation();
  }

  galleryImageTargetDisconnected() {
    console.log('galleryImageTargetDisconnected');

    if (this.galleryImageTargets.length) {
      this.recountSlides();
      this.renderNavigation();
      this.renderSlides();
    }
  }

  galleryMeatballsTargetDisconnected() {
    if (this.galleryImageTargets.length) {
      this.renderMeatballs();
    }
  }

  newImageFormTargetConnected() {
    console.log('newImageFormTargetConnected');
  }

  newImageFormTargetDisconnected() {
    console.log('newImageFormTargetDisconnected');

    if (this.galleryImageTargets.length) {
      this.moveToSlide({
        params: { position: this.galleryImageTargets.length },
      });
    }
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

    this.renderNavigation();
    this.renderSlides();
    this.renderMeatballs();
  }

  moveToSlide({ params: { position } }) {
    console.log('moveToSlide', position);
    this.index = position - 1;

    this.renderNavigation();
    this.renderSlides();
    this.renderMeatballs();
  }

  recountSlides() {
    console.log(this.index, this.galleryImageTargets.length);

    if (this.index === this.galleryImageTargets.length) {
      this.index--;
    }

    console.log('after', this.index);
  }

  renderSlides() {
    this.galleryImagesRailTarget.style.transform = `translateX(-${
      100 * this.index
    }%)`;
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

  renderMeatballs() {
    console.log('renderMeatballs', this.index);

    this.galleryMeatballTargets.forEach((meatball) => {
      meatball.classList.remove(this.currentClass);
    });

    const meatball = this.galleryMeatballTargets[this.index];
    meatball.classList.add(this.currentClass);

    console.log(meatball);
  }
}
