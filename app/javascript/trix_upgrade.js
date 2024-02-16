document.addEventListener('trix-initialize', updateActions);

document.addEventListener('trix-action-invoke', function (event) {
  console.log(event.actionName);
  // if (event.actionName === 'x-log') {
  //   console.log('Log called');
  // }
});

function updateActions() {
  const editors = document.querySelectorAll('trix-editor');

  const myAction = {
    test: true,
    perform: sayHi,
  };

  console.log(document.querySelector('trix-editor').editorController.actions);

  editors.forEach((editor) =>
    Object.assign(editor.editorController.actions, { myAction })
  );

  console.log(document.querySelector('trix-editor').editorController.actions);
}

function sayHi() {
  console.log('Hi!');
}
