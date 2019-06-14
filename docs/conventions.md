# Conventions

## Organization

### How the project is organized

First off, this project was designed to be organized by *feature*, not by *layer*. This means that files are sort by what part of the game they belong to, opposed to what type of file they are. Furthermore, features that belong to other features (i.e. when one feature does not exist outside of the other feature) are placed in child directories.

### Why the project is organized this way

The reasoning behind this is simple: when a feature is added/modified/removed, you don't need to traverse the entire project directory to access the files, because they are all in one place.

## Godot / Scripting

- Modify properties on the scene instead of the instance, unless the changes on the instance are distinctly unique to that instance.
- TODO: add more

## Thank you

Thank you for checking out the conventions on this page. If you can think of any improvements, please open an issue!
