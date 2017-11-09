---
layout: post
title: 'Webapp first: An approach to developing for mobile'
date: 2012-05-21 07:21:17+00:00
tags:
  - future friendly
  - mobile
  - progressive enhancement
  - webapp
permalink: developing-mobile-webapp-first
---

Mobile web apps are not at the same level of native ones. Until browsers don't implement HTML5 API specifications to access device hardware (device API, audio, video), implement push notifications, and improve general performance (animations, scroll) web apps will not be able to deliver the experience that can't be reach through native development.

However, there are some advantages when taking a webapp first approach for mobile development.

<!-- more -->
## UI mocking
Some UI designers are so familiar with web that they use HTML+CSS to implement native apps mockups. Then, this mockups are used by iOS or Android developers to implement the app UI. Why don't take advantage of that web mockup and use it for a web app?

## <a name="hybrid"></a>Hybrid application
Your web development can be easily reused to make a hybrid application. Your native app can be a wrapper of your webapp, and you can use PhoneGap or Titanium to to access hardware through JS bridges. In addition, you can iterate and port parts of your application to native controls if you realize it is more suitable. You don't lose your previous development, since you can reuse them in your mobile site.

Take Google+ iPhone app as an example:
![Google+ iPhone app](/assets/images/posts/google-plus-hybrid.jpg)

The Google+ iPhone app was basically a wrapper around their mobile webapp. From there, they have evolve it to a much richer one. However, certain features like the login page remain the same. And there is the mobile site, that looks a lot like the 'old' iPhone app.

## Testing new features
Deploying changes in a webapp is easier than building and distributing an app. Thus, you can easily perform A/B testing or introduce new features on your webapp and use it as a way to get feedback before porting those changes to native apps.

## Defensive development - Future Friendly
Having a webapp makes your solution compatible with future devices, no matter what OS they are running. Your users will be able to use your application on their mobile phones through their browser. [Open Web Device](http://www.openwebdevice.com/) gaining traction? You are ready. [Intel Mobile phone](http://www.slashgear.com/intels-first-medfield-phone-coming-this-week-claims-ceo-17223318/)? You are ready too. E-book reader? Of course! And take into account that your application wouldn't be compatible with these devices if you had chosen any of current 'native' environments.

In addition, as OS software updates are being released and more powerful browsers are available, our web apps will behave better. If we have embraced progressive enhancement, our apps will be able to take advantage of most recent HTML5 APIs as soon as the browser in which they are running supports them.
