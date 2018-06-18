# FAQ

### Do you have any general contribution guidelines?
We don't want to restrict your creativity, but we have a few rules to follow:
- Search previous suggestions before making a new one, as yours may be a duplicate.
- Titles should be capitalized.
- Keep descriptions short and simple.
- End all descriptions with a full stop/period.
- Check your spelling and grammar.
- Make sure your text editor is set to remove trailing whitespace.
- Follow [KISS](https://en.wikipedia.org/wiki/KISS_principle) principle

### What the syntax should I use to format everything?
Please use [GFM(GitHub Flavored Markdown)](https://guides.github.com/features/mastering-markdown/#GitHub-flavored-markdown)


### How can I add a new cheatsheet?
- Fork this repository
- Create a new branch for your cheatsheet
- Open a pull request with your changes
- Wait for the approval
- Feeling awesome 🤓

### Could you please explain where do I need to put my cheatsheet?
Find a folder for your department(e.g. `android`), create a new `.md` file with content. This is your cheatsheet. You also need to add reference to this markdown file in the main [README.md](../README.md) file contents. Please use A-Z sort for the titles.

### What if I want to insert some image to my cheatsheet?
Cool, just create a new folder `assets` in your department and put your images there. Then you can reference just like that:
```
![Demo](demo.png)
```

### What if I want custom image size or alignment?
Unfortunately, the GFM doesn't allow you to do this. But you could use HTML for this purpose:
```
<p align="center">
  <img src="./assets/awesome.svg" width="350">
</p>
```

If you have any other questions just ask [4doge](https://github.com/4doge).

Thanks for the contributing! ❤️
