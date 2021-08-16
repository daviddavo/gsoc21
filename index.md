## Welcome to my GSoC 2021 Report

You can use the [editor on GitHub](https://github.com/daviddavo/gsoc21/edit/gh-pages/index.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/daviddavo/gsoc21/settings/pages). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://docs.github.com/categories/github-pages-basics/) or [contact support](https://support.github.com/contact) and we’ll help you sort it out.

## Things to do:

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
