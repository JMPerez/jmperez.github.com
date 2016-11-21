---
layout: post
title: 'Generating google images sitemap with C#'
description: This is the C# code to generate a XML images sitemap to let Google Images
  Bot index more easily the pictures of your site.
date: 2010-07-24 09:02:20+00:00
tags:
  - google
  - sitemap
  - xml
permalink: google-images-sitemap-c-asp-net
---

Today I have implemented an action in ASP.Net MVC that generates a sitemap containing the images of a website we are developing, just to check how this affects to the amount of images indexed in google images.

The XML structure, as well as the optional parameters, are defined on [Adding image information to a Sitemap](http://www.google.com/support/webmasters/bin/answer.py?answer=178636) on Google Webmaster central.

<!-- more -->
The code I use is the following one:

```csharp
XNamespace ns = "http://www.sitemaps.org/schemas/sitemap/0.9";
XNamespace nsImage = "http://www.google.com/schemas/sitemap-image/1.1";
XDocument xmlDoc =
  new XDocument(
    new XDeclaration("1.0", "UTF-8", null),
    new XElement(ns + "urlset",
      new XAttribute(XNamespace.Xmlns + "image", nsImage.NamespaceName),
        from image in images
        select
          new XElement(ns + "url",
            new XElement(ns + "loc", image.UrlImage),
            new XElement(nsImage + "image",
              new XElement(nsImage + "loc", image.UrlPage)))
          ));

return Content(xmlDoc.ToString());
```

where **images** is a list of objects that contains the url of the page where the image appears (UrlPage) as well as the url for the source image file (UrlImage). In this example, each page would contain just one image.

Optional parameters can be added:

- **Title**: It would be equivalent to the alt text of the image
- **Caption**: A brief description of the image
- **Geo_location**: From the documentation, it seems it is the name of the place / city depicted in the picture or where it was taken, and not the geo coordinates.
- **License**

I hope this can help those people willing to try this feature from Google.
