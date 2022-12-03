# Stimulus Reflex/Action Cable disconnect demo

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/phacks/stimulus-reflex-action-cable-disconnect-repro)

This repository reproduces the issue described on the [StimulusReflex Discord](https://discordapp.com/channels/629472241427415060/1042779018518347786), quoted below:

> I found that if, for some reason (a slow network or a large HTML payload, likely both), a morph operation takes more than ~6 seconds to be sent from the server to the client via the WebSocket connection, the WS connection is dropped and the morph never applies.
>
> Here’s what I believe is happening:
> - ActionCable is sending a ping message every 3 seconds from the server;
> - On the client, the ActionCable JS library listens to ping events. After about 6 seconds without any ping events, (around 2 expected pings), it considers itself “disconnected”, shuts down the current connection and opens up a new one;
> - When streaming a SR response via the WebSocket connection, that connection is “busy” and does not transmit ping events;
> - Thus, any SR response that takes more than ~6 seconds to transmit will make the AC client disconnect itself and open up a new connection. The SR response never reaches the client in that case.

To reproduce:

- Open this repo on GitPod, or locally (follow the instruction provided on [the repository this one was forked from](https://github.com/marcoroth/rails7-stimulus-reflex-esbuild) to do so)
- Start the server and visit the homepage
- Open the DevTools on the Network panel
- Set your browser to the “Fast 3G” network throttling
- Filter the panel on the `WS` (WebSocket) network traffic
- Click the `Increment ping issue click counter` button
- You will see the `cable` connection drop and a new one created, as well as no updates shown on the page
- Set your browser to the “No throttling” mode
- Refresh the page
- Click the `Increment ping issue click counter` button again
- You should not see the connection drop, and you should see the reflex update the page
