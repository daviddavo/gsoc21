---
lang: en-GB
toc: true
---
# Fixing IHaskell-Widgets
<figure class="video_container">
  <video autoplay loop muted playsinline>
    <source src="{{site.baseurl}}/assets/demos/bincounter.webm" type="video/webm">
    <source src="{{site.baseurl}}/assets/demos/bincounter.mp4" type="video/mp4">
  </video>
</figure>

## Show me the code!
The main PR with almost all the commits is [#1242: Updating IHaskell-widgets](https://github.com/gibiansky/IHaskell/pull/1242),
but you can find every PR I have made to the project before finishing GSoC [clicking here](https://github.com/gibiansky/IHaskell/pulls?q=is%3Apr+author%3Adaviddavo+created%3A%3C2021-08-23+).

## Demo

## Technical difficulties

## Things to do

If you want to continue or contribute to this project, here are some things that
are still to be done as of today, 16th of August of 2021.

- [ ] Adding unit testing
- [ ] Adding integration testing using visual regression
- [ ] Make the output widget capture output
- [ ] Make the layout widgets more "Haskellian" using singletons instead of strings
- [ ] Create a serializable `Color` data type instead of using strings. (Or using one from an external library)
- [ ] Overloading `setField` so it can be used with wrapper types without using the data constructor every time
  - E.g: `setField w Index 3` should just work instead of having to use `setField w Index $ Just 3`
- [ ] Adding some utilities functions
  - Creating a media widget given a filename
  - Getting the selected label from a selection widget (instead of the value)
- [ ] Improve the backend's validation of attributes.
  - E.g: Now you're able to set an IntValue out of bounds in a Slider
