# ricky
**ricky** is a Ruby wiki engine that supports various types of markup
formats using GitHub's [markup](https://github.com/github/markup).

## Features

* **Custom Themes**: Any HTML file can become a theme in seconds!
* **Arbitrary Files**: All files in _wiki/_ will be hosted.

## Use
```
ruby ricky.rb theme.html
```

In a folder called _wiki/_, create files such as _test.md_ and they
will be rendered when you go to [localhost/test](http://localhost/test).

The best way to version control your files is to make a git repository
in _wiki/_, you can then upload this to GitHub and have you wiki be
open source. Add a Heroku hook and bam, instant wiki anyone can edit.

## Themes
Themes are normal HTML documents that contain tags that are replaced
when the page is rendered.

* `{% title %}` will be replaced with the title of the page.
* `{% content %}` will be replaced with the content of the page.