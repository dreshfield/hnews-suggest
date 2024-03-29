# HNews Suggest

[![Gem Version](https://badge.fury.io/rb/hnews-suggest.svg)](http://badge.fury.io/rb/hnews-suggest)

Automatically suggest Hacker News articles from the command line!

## About

I am a frequent reader of Hacker News, and thought it would be fun to make something which would suggest an article without having to read through the front page.

The more you use the gem, the smarter it gets. After an article is suggested you have the opportunity to feed back into the system. Depending on whether you liked the article or not, the main keywords from the article will be indexed and used for future suggestions.

__note__: It's worth mentioning that the method used to rank and suggest articles here is pretty simple. The main keywords are taken from the articles title and content and ranked over time. This can lead to some inaccuracies. In the future, I plan on replacing this system with one based on natural language.

## Installation

Installation is super easy! (if you have ruby already installed).

```
gem install hnews-suggest
```

## Usage

Using the gem is really simple too!

```
hnews suggest
```

This command will suggest the top ranked article currently on the Hacker News front page. The article's title and URL will be displayed, followed by a prompt asking for your feedback. If you liked the suggested article, enter `y`. Otherwise enter `n`.

You can also pass the `--open` option to the suggest command. This will open the suggested article in your browser.

There's also the `learn` command:

```
hnews learn
```

This will list all thirty articles currently on the front page, and allow you to pick articles outside of the suggestion system. This is useful if you want to "teach" the system, or if you see an article you like which is not appearing in the suggestion results.

## License

Released under the MIT license. See the [LICENSE][] file for further details.

[license]: LICENSE
