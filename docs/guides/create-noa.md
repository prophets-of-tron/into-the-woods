# Designing Non-object Actions

- Create the NOA:
  - Create a directory in res://world/player/noa/action.
  - Create an icon texture that represents your action.
  - Create a scene that inherits from ./base/NOA.tscn and a script that extends `NOA`, and set its *Texture* property.
  - You can implement `perform()` for the action's functionality.
- Add the NOA to the NOA toolbar:
  - Add a new NOASlot instance as a child of NOAToolbar, and add an instance of your new NOA as an only child to that slot. You should be able to use it in the game now!
