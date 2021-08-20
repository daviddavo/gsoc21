---
lang: en-GB
toc: true
---
# Fixing IHaskell-Widgets
<figure class="video_container">
  <video autoplay loop muted playsinline poster="{{site.baseurl}}/assets/demos/bincounter.gif">
    <source src="{{site.baseurl}}/assets/demos/bincounter.webm" type="video/webm">
    <source src="{{site.baseurl}}/assets/demos/bincounter.mp4" type="video/mp4">
    Sorry, your video does not support the video tag
  </video>
</figure>

## Show me the code!
The main PR with almost all the commits is [#1242: Updating IHaskell-widgets](https://github.com/gibiansky/IHaskell/pull/1242),
but you can find every PR I have made to the project before finishing GSoC [clicking here](https://github.com/gibiansky/IHaskell/pulls?q=is%3Apr+author%3Adaviddavo+created%3A%3C2021-08-23+).

## I want to use it
You can test and play a bit with it and run the sample notebooks using this [binder link]({{site.binder.binder_url}}). Using binder is fine if you only want to try it a bit without downloading and installing, but it gets a bit slow when you want to do more complex things.

You can follow the install guide at the project's [README](https://github.com/gibiansky/IHaskell#readme).

## Technical difficulties
Here I'll explain some solved and unsolved problems that I stumbled upon while working on the project

### The message specification
The purpose of this GSoC was to fix ihaskell-widgets, which wasn't working properly
because the widget messaging specification changed A LOT.

I had to navigate through lots of resources and do some "reverse engineering" using
network inspection tools (tcpdump).

Some of these resources have been compiled to [MsgSpec.md](https://github.com/gibiansky/IHaskell/blob/master/ihaskell-display/ihaskell-widgets/MsgSpec.md)

### The incredible world of dependent types
This library was written using the concept of *dependent types*. These are types whose
definition depends on a value. In IHaskell-widgets, using dependent types allows
checking properties of the widgets at compile time, using the powerful Haskell's
type system.

For example, in IHaskell-widgets, the type of a widget consists of an *array of fields*. Then we can check in `setField` if the field that we want to set is among the array of fields of the widget **at compile time**!

But Haskell doesn't support dependent types (yet), so we use the next best thing: a pattern called `Singleton` that introduces *reflection* and *reification* and allows us to get types that depend
on values at runtime.

This was the most complex library I've had to learn to use, and it took me a lot of reading blogs and papers. If you want to learn more you can find more info here:
- [Dependent types](https://wiki.haskell.org/Dependent_type) on Haskell Wiki
- [Dependently Typed programming with singletons](https://www.researchgate.net/publication/254464156_Dependently_Typed_programming_with_singletons). Richard A. Eisenberg et Al. 2012.
- [Introduction to Singletons](https://blog.jle.im/entry/introduction-to-singletons-1.html) by Justing Le
- [Singletons](https://hackage.haskell.org/package/singletons) library

### Capturing the output with the Output Widget
In Python, we are able to capture the output of any function using the `Output` widget.

The output generated from the following lines would be captured and displayed wherever
the `Output` widget has been displayed.

```python
with out:
  display(YouTubeVideo("dQw4w9WgXcQ"))
  for int i in range(10):
    print(i, "Hello World!")
```

What this code does is that it changes the `msg_id` attribute to the msg_id of the `execution_request`. For this to be possible, the output widget has to somehow access parts of the
*Kernel state* to obtain that `msg_id`.

Now, what about implementing it in Haskell? We could do a simple interface with a custom monad. Or with a function that executes a function while capturing the output, like this:
```haskell
capture :: OutputWidget -> IO () -> IO ()
capture o f = do
  startCapturing o
  f
  endCapturing o
  where startCapturing = setField o MsgID ???
        endCapturing = setField o MsgID ""
```

Now, what's the problem? Haskell is a functional language without side effects, so it's a bit
more difficult than just accessing the `msg_id`... In conclusion, we have two options:
- Passing the `msg_id` *from here to there* as a parameter in the `comm` function of the widget (or any other function that is called between the `execution_request` and the capturing)
- Having a `getExReqMsgId :: IO String` function that accesses an `IORef` of the kernel state and
gets us the message ID.

I think the latest is a bit dirtier, but easier to read.

### Making the Controller Widget work
The controller widget is created with empty arrays of Buttons and Axes. When a controller
is connected and configured, it passes via `comm` its new attributes such as its name, mapping, etc. (like every widget modifiable by the frontend does). It also passes an array of Buttons and Axes widgets IDs. The problem is where do these IDs come from. Do we have to create widgets with these IDs?
Are these widgets already created and on the kernel state? How do we access the kernel state?

We end with a problem similar to "getting the execution request msg_id", because we have to
access the kernel state, and get a widget given it's ID... So we either pass some part of the kernel
state in the `comm` function, or we create an `getAxis :: String -> IO ControllerAxis` function.

## Things to do

If you want to continue or contribute to this project, here are some things that
are still to be done as of today, 16th of August 2021. Some of them have been discussed at [Technical difficulties](#technical-difficulties)

- [ ] Adding **unit testing**
- [ ] Adding integration testing using **visual regression**
- [ ] Make the output widget **capture output**
- [ ] Make the layout widgets more "Haskellian" using *dependent types* instead of strings
- [ ] Create a serializable `Color` data type instead of using strings. (Or using one from an external library)
- [ ] Overloading `setField` so it can be used with wrapper types without using the data constructor every time
  - E.g: `setField w Index 3` should just work instead of having to use `setField w Index $ Just 3`
- [ ] Adding some **utilities functions**
  - Creating a media widget given a filename
  - Getting the selected label from a selection widget (instead of the value)
- [ ] Improve the backend's **validation of attributes**.
  - E.g: Now you're able to set an IntValue out of bounds in a Slider
- [ ] **Optimizing ihaskell-widgets**. Currently, there is an update message sent for
every `setField` done, while ipython sends a final update message when all changes
have been made.
