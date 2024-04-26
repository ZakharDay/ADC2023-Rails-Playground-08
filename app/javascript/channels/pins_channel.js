import consumer from 'channels/consumer';

consumer.subscriptions.create('PinsChannel', {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('PinsChannel connected');
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log('PinsChannel disconnected');
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('PinsChannel received', data);

    const likeButton = document.getElementById(`like_pin_${data.id}`);

    if (likeButton) {
      const likeButtonCounter = likeButton.querySelector('a .counter');

      if (data.likes == 0) {
        likeButtonCounter.innerText = '';
      } else {
        likeButtonCounter.innerText = data.likes;
      }
    }
  },
});
