import consumer from 'channels/consumer';

consumer.subscriptions.create('NotificationsChannel', {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('connected');
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log('disconnected');
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('received', data);

    const container = document.getElementById('notifications');
    const notification = document.createElement('div');
    const link = document.createElement('a');

    notification.classList.add('notification');
    link.innerText = data.body;
    link.href = 'http://localhost:3000' + data.url;

    notification.appendChild(link);
    container.appendChild(notification);
  },
});
