# Contributing

Welcome, and thanks for choosing us over your office job!&nbsp;&nbsp;&nbsp;
Just kidding, but thanks for looking into contributing to Into the Woods. It's people like you who make this game worth playing!

#### Table of Contents

- [Introduction](#introduction)
- [Reporting a Bug](#reporting-a-bug)
- [Requesting a Feature](#requesting-a-feature)
- [Submitting a Code Contribution](#submitting-a-code-contribution)
- [Styleguides](#styleguides)
- [Important Links](#important-links)

## Reporting a Bug

Bugs are tracked as [GitHub issues]. Open an issue:

- Use a clear and descriptive title
- Describe exact steps to reproduce the problem
- Describe the behavior produced by those steps and explain how it is problematic
- Explain what behavior you expected to see

## Requesting a Feature

Enhancements are tracked as [GitHub issues] too:

- Use a clear and descriptive title
- Provide a step-by-step description with many details
- Provide specific examples to demonstrate the steps
- Explain why this enhancement would improve the game

## Submitting a Code Contribution

#### Testing

**todo (very soon)**

#### Setting Up

All you will need is [Godot](https://godotengine.org/download). Then, [fork](https://github.com/prophets-of-tron/into-the-woods/fork) and clone

```
$ git clone https://github.com/YOUR-NAME/into-the-woods.git
$ git remote add upstream
```

#### Finding a Task

All user stories and tasks are posted on the [Kanban board](https://tree.taiga.io/project/clabe45-into-the-woods). Once you find one you're interested in, you can start working on it. Please comment and say you want to do it (so a moderator can mark it as "in progress", letting other contributors know it's being worked on).

*Please don't make changes that are not listed as a user story or task.*

#### Making Changes

Create your feature branch

```
$ git checkout -b foo-bar
```

Commit your changes (see the [styleguide](#styleguides))

```
$ git commit -m ':emoji: Add some foo bar'
```

Push to the branch

```
$ git push origin foo-bar
```

#### Submitting Changes

First integrate your changes with any recent changes upstream, by rebasing:

```
$ git fetch upstream
$ git rebase upstream/master
```

Push the changes you made to your fork's remote repository:

```
$ git push origin foo-bar
```

Then, open a pull request from your topic branch to the main repository.
- Make the pull request's title concise and include the [the Taiga user story or task](https://tree.taiga.io/project/clabe45-into-the-woods/kanban) number. Example: _Fix foo bar (\#5)_
- Please link to the Taiga user story or task in the description

Your code will then be looked over by one or more reviewers, who may ask you to change parts of your code so it can integrate with the existing codebase.

## Styleguides

#### Commit Messages

- Use the imperative mood ("Add feature" not "Adds feature")
- Limit the first line to 72 characters or less (if possible)
- Consider beginning the first line with [an emoji](http://gitmoji.carloscuesta.me/)
- Explain why you made the change (in the body)

For example:

```
:sparkles: Add foo bar

This resolves task #0
```

[github issues]: https://guides.github.com/features/issues

## Important Links

- [Developer documentation](docs)
