import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    // this.element.textContent = "Hello World!"
    console.log('Hello, Stimulus!', this.element);
  }

  process() {
    console.log('process');

    // ('https://speech.googleapis.com/v1p1beta1/speech:recognize');

    // const body = {
    //   audio: {
    //     content:
    //   },
    //   config: {
    //     enableAutomaticPunctuation: true,
    //     encoding: 'LINEAR16',
    //     languageCode: 'ru-RU',
    //     model: 'default',
    //   },
    // };

    // const grammar =
    // '#JSGF V1.0; grammar colors; public <color> = aqua | azure | beige | bisque | black | blue | brown | chocolate | coral | crimson | cyan | fuchsia | ghostwhite | gold | goldenrod | gray | green | indigo | ivory | khaki | lavender | lime | linen | magenta | maroon | moccasin | navy | olive | orange | orchid | peru | pink | plum | purple | red | salmon | sienna | silver | snow | tan | teal | thistle | tomato | turquoise | violet | white | yellow ;';

    const SpeechRecognition =
      window.SpeechRecognition || window.webkitSpeechRecognition;

    // const SpeechGrammarList =
    // window.SpeechGrammarList || window.webkitSpeechGrammarList;

    const recognition = new SpeechRecognition();
    // const speechRecognitionList = new SpeechGrammarList();
    // speechRecognitionList.addFromString(grammar, 1);
    // recognition.grammars = speechRecognitionList;
    recognition.continuous = true;
    recognition.lang = 'ru-RU';
    recognition.interimResults = true;
    recognition.maxAlternatives = 1;

    const diagnostic = document.getElementById('output');
    const bg = document.querySelector('html');

    recognition.start();
    console.log('Ready to receive a color command.');

    recognition.onresult = (event) => {
      console.log(event.results);

      // const color = event.results[0][0].transcript;
      diagnostic.innerText = '';

      for (let index = 0; index < event.results.length; index++) {
        const result = event.results[index];

        const span = document.createElement('span');
        span.innerText = result[0].transcript;
        diagnostic.appendChild(span);
      }

      // event.results[0].forEach((result) => {
      //   const span = document.createElement('span');
      //   span.innerText = result.transcript;
      //   diagnostic.appendChild(span);
      // });

      // diagnostic.textContent = `Result received: ${color}`;
      // bg.style.backgroundColor = color;
    };

    recognition.onspeechend = (event) => {
      // console.log('onspeechend', this.process());
    };

    recognition.onaudioend = (event) => {
      console.log('onaudioend');
    };

    recognition.onsoundend = (event) => {
      console.log('onsoundend');
    };
  }
}
