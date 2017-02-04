---
layout: post
title: Using MediaRecorder API for screen recording on the web
date: 2016-12-09 01:05:00+01:00
description: Record your webcam and screen using Javascript to create screencast from your browser.
image:
  url: /assets/images/posts/screenflow-poster.jpg
  width: 1200
  height: 761
tags:
  - images
permalink: mediarecorder-api-screenflow
---

At [CSSConf AU 2016](/cssconf-au-2016/), [Soledad Penadés](https://soledadpenades.com/) gave a talk called "[Real time front-end alchemy](https://soledadpenades.com/files/t/2016_rtalchemy/)". It was full of examples of combining [MediaStreams](https://developer.mozilla.org/en-US/docs/Web/API/Media_Streams_API) with audio and video manipulation.

Something I didn't know was that you can record audio and video on the browser without any plugins. You can combine audio from the microphone, video from a canvas, dynamically generated content... you name it. Even recording a window or the entire screen and exporting it as a video.

<!-- more -->

The best way to learn is by practising and, [quoting Soledad](https://soledadpenades.com/files/t/2016_rtalchemy/#65), "we need you to play with it, contribute and help us make it better". By trying these new APIs out we let browser-vendors know that these tools are useful, and we can test and provide early feedback.

## The project

<div class="videoWrapper">
<iframe width="720" height="450" src="https://www.youtube.com/embed/tOWwV8ZRn3g" frameborder="0" allowfullscreen></iframe>
</div>

I had this idea about creating a [ScreenFlow](http://www.telestream.net/screenflow/overview.htm)-like prototype. I would show my webcam in a corner of the screen and I would generate a video combining audio from the mic and the image from the screen.

I Googled a bit, and found very few sites talking about these APIs. Pretty much only [MDN](https://developer.mozilla.org/en-US/docs/Web/API/MediaStream_Recording_API) and [other post by Sole](https://hacks.mozilla.org/2016/04/record-almost-everything-in-the-browser-with-mediarecorder/). I thought this small experiment would also help those searching for some examples.

_Note: As of December 2016 this demo is only supported on Firefox. Chrome is not supported out of the box, needing an extension and lots of custom code (see this WebRTC experiment for more information. It will show your camera, but won't record anything._

### The code

The code for the project is at [JMPerez/screenflow on GitHub](https://github.com/JMPerez/screenflow) and a demo is available on [jmperezperez.com/screenflow](https://jmperezperez.com/screenflow/).

Let's have a look at the most important code fragments. First of all, we define functions to request access to the different media sources:

```js
// we ask for permission to record the window
// mediaSource could also be 'screen' if we wanted
// to record the entire screen
const getStreamForWindow = () => navigator.mediaDevices.getUserMedia({
  video: {
    mediaSource: 'window'
  }
});

// we ask for permission to record the audio and video from the camera
const getStreamForCamera = () => navigator.mediaDevices.getUserMedia({
   audio: true
});
```

Now, we execute them, one after the other one. I tried to execute both in parallel, believing that the browser would combine both requests in the permission dialog, but that didn't work. So the idea is to request access to the webcam, insert a `<video>` element with the media from the camera and then request access to the screen and record it.

```js
getStreamForCamera().then(streamCamera => {
    // we know have access to the camera, let's append it to the DOM
    appendCamera(streamCamera);
    getStreamForWindow().then(streamWindow => {

      // we now have access to the screen too
      // we generate a combined stream with the video from the
      // screen and the audio from the camera
      var finalStream = new MediaStream();
      const videoTrack = streamWindow.getVideoTracks()[0];
      finalStream.addTrack(videoTrack);
      const audioTrack = streamCamera.getAudioTracks()[0];
      finalStream.addTrack(audioTrack);
      this.recorder = new MediaRecorder(finalStream);

      // we subscribe to 'ondataavailable'.
      // this gets called when the recording is stopped.
      this.recorder.ondataavailable = function(e) {
        // let's create a blob with e.data which has the
        // contents of the video in webm
        var link = document.createElement('a');
        link.setAttribute('href', window.URL.createObjectURL(e.data));
        link.setAttribute('download', 'video_' + Math.floor((Math.random() * 999999)) + '.webm');
        link.style.display = 'none';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
      }

      // start recording
      this.recorder.start();
    });
  });
```

Now, we finally need to call `this.recorder.stop()` whenever we want to stop the recording, which will make the browser save the file automatically. In my example, I'm attaching a key event listener for the "escape" key.

### A note about permissions

In order to make this work you will need to whitelist the domain trying to record your screen. On Firefox, `localhost` will work out of the box. If you want to publish the code somewhere else, like GitHub Pages, make sure you whitelist it.

On Firefox, navigate to `about:config` and look for the key `media.getusermedia.screensharing.allowed_domains`. Add your domain to the list and restart the browser. Then, when you are running the code, the user will be able to grant access for both the webcam and the screen.

It is unclear whether this will be how a user lets a site record their screen, but it is how this works at the moment.

### A step further, making this embeddable

The example code worked fine, but I wanted to take it a bit further. What if I wanted to use this "recording" functionality in more than one project? Also, given that the user has to whitelist a domain, we could serve the code from an `iframe` on that domain, so we wouldn't need to add more domains to the `about:config`.

The final version of the prototype is based now on a script that you include on a page. The script appends an `iframe`, which executes the code we saw above and shows the output from the webcam at full size. Apart from the `iframe`, it also binds several key event listeners to toggle the visibility and size of the `iframe`.

These are the keys you can press to perform some actions:
- Escape: finishes the recording and saves the file
- s: Switches the camera between full page and picture-in-picture
- a: Toggles the visibility of the camera

You can then include the script to any page to get this screen recording functionality. For instance, we can include `https://jmperezperez.com/screenflow/lib/embed.js` on a codepen and record a screencast.

### Limitations

Keep in mind this is only a proof of concept and doesn't have any real utility. If you are serious about recording a screencast, don't use this hack :)

There are, of course, some limitations:
- The iframe with the camera is shown on top of the hosting page, but it will be hidden if we put some other window on top.
- If we navigate from the hosting page to somewhere else we will lose the recording. This can be workaround by having, in the hosting page, an iframe for the camera and another iframe for the page we are recording, in full screen
- If we click on the iframe with the camera, the key events will stop working because the hosting page doesn't receive those. This can be solved sending `postMessage`s from the iframe to the hosting page.
