# HNews Suggest

Automatically suggest Hacker News articles from the command line!

## About

This gem came about from wanting to learn more about ruby, and machine learning. I am a frequent reader of Hacker News, and thought it would be fun to make something which would suggest an article without having to read through the front page.

The more you use the gem, the smarter it gets. After an article is suggested you have the opportunity to feed back into the system. Depending on whether you liked the article or not, the main keywords from the article will be indexed and used for future suggestions.

__note__: It's worth mentioning that the method used to rank and suggest articles here is pretty simple. The main keywords are taken from the articles title and content and ranked over time. This can lead to some inaccuracies. IIn the future, I plan on replacing this system with one based on natural language.

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

This will list five articles which you may like. You will be prompted to pick one of the five, and prompted again on whether you liked or disliked the article. Your answers here will influence future suggestions.

```
hnews learn
```

This will list all thirty articles currently on the front page, and allow you to pick articles outside of the suggestion system. This is useful if you want to "teach" the system, or if you see an article you like which is not appearing in the suggestion results.
