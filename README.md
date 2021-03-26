# README

This app is the backend for a Slack clone with no auth.

# Setting up this app

You can set up this rails app on your local machine by cloning down the repo and running:

```
bundle install
rails db:create
rails db:migrate
rails s
```

# Using Websockets

This app uses websockets to broadcast when a new Message has been created belonging to a Channel.

The workflow in JS (with details below) is:

- Open a websocket to the `/cable` route.
- When it successfully opens:
- Subscribe to a channel
- Set an event listener for messages

### Opening a WebSocket:
In vanilla JS, you can interact with this app by connecting to the websocket route at `/cable` (default is "ws://localhost:3000/cable" in development.)

`const socket = new WebSocket("ws://localhost:3000/cable")`

### Waiting for it to open

If you immediately try to subscribe to a channel in Vanilla JS, you will receive an error. Instead, add an event listener for an `open` event to the socket or set the socket's `onopen` attribute to a callback.

`socket.onopen = console.log`
or
`socket.addEventListener("open", console.log)`

### Subscribe to a Channel

You can send a message to the server to start a subscription.

This format seems to be the one that works.

This exact format works for unsubscribing, with the command changed to "unsubscribe".

The following commands were stolen largely wholesale from [this blog post](https://medium.com/@valentinowong/using-rails-action-cable-with-a-vanilla-javascript-front-end-1e00ed90067e).

```JavaScript
const msg = {
  command: 'subscribe',
  identifier: JSON.stringify({
      id: //some id,
      channel: 'ChannelChannel'
  }),
}
socket.send(JSON.stringify(msg))
```

### Listening for a message

To begin listening for a message, add an event listener for a `message` event to the socket or set the socket's `onmessage` attribute to a callback.

`socket.onopen = console.log`
or
`socket.addEventListener("open", console.log)`

In addition to receiving message broadcasts, your open websocket will receive regular pings. Those messages, when parsed with JSON, will have a type attribute "ping" and can be ignored.
