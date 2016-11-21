---
layout: post
title: 'Tracking action execution time in ASP.Net MVC'
date: 2010-06-21 16:33:44+00:00
description: This post shows how we can easily track the execution times of our actions
  and controllers by using a filter attribute
tags:
  - asp net mvc
permalink: tracking-action-execution-time-in-asp-net-mvc
---

Using filter attributes we can add features to our actions or controllers easily. In this case, I have implemented an action filter attribute that stores how much time has taken to execute an action.

<!-- more -->
```csharp
public class TrackTimeFilter : ActionFilterAttribute
{
  Stopwatch stopWatch;
  public override void OnActionExecuting(ActionExecutingContext filterContext)
  {
    stopWatch = new Stopwatch();
    stopWatch.Start();
  }

  public override void OnResultExecuted(ResultExecutedContext filterContext)
  {
    stopWatch.Stop();
    Log(filterContext.RouteData, stopWatch.ElapsedMilliseconds);
  }

  private void Log(RouteData routeData, long time)
  {
    var controllerName = routeData.Values["controller"];
    var actionName = routeData.Values["action"];
    ElapsedTime.InsertEntity(time, controllerName + "." + actionName);
  }
}
```

Here we have used Stopwatch to accurately measure the time from the moment the action starts its execution to the moment when a return is made (usually to start rendering the view).

**ElapsedTime** is a static class that stores the measures, so that we can see the times (I use a Asp.Net MVC view that runs through the values and shows the grouped times.

```csharp
public static class ElapsedTime
{
  public static Dictionary IdentifiedElapseds = new Dictionary();

  public static void InsertEntity(long milliseconds, string identifier)
  {
     lock (IdentifiedElapseds)
     {
       ElapsedTimeEntity entry;
       if (!IdentifiedElapseds.TryGetValue(identifier, out entry))
       {
         entry = new ElapsedTimeEntity();
         IdentifiedElapseds.Add(identifier, entry);
       }

       entry.LastTime = milliseconds;
       entry.LastDate = DateTime.UtcNow;
       entry.TotalTime += milliseconds;
       entry.Count++;

       if (milliseconds &lt; entry.MinTime)
         entry.MinTime = milliseconds; entry.MinDate = DateTime.UtcNow;
       if (milliseconds &gt; entry.MaxTime)
         entry.MaxTime = milliseconds; entry.MaxDate = DateTime.UtcNow;
     }
  }
}

public class ElapsedTimeEntity
{
  public long LastTime = 0;
  public long TotalTime = 0;
  public int Count = 0;
  public long MinTime = long.MaxValue;
  public long MaxTime = long.MinValue;
  public double Average
  {
    get { return (TotalTime / Count); }
  }

  public DateTime MinDate;
  public DateTime MaxDate;
  public DateTime LastDate;
```
