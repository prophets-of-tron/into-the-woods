# Conventions

## Organization

### How the project is organized

First off, this project is designed to be organized by feature, instead of by layer. This means that files are sorted by what part of the game they belong to, opposed to what type of file they are. Furthermore, features that belong to other features (i.e. when one feature does not exist outside of the other feature) are placed in child directories.

## Godot / Scripting

- Modify properties on the scene instead of the instance, unless the changes on the instance are distinctly unique to that instance.
- TODO: add more

## Conclusion

Thank you for checking out the conventions on this page. If you can think of any improvements, please open an issue!
