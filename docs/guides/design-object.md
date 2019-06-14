# Designing Objects

## Procedure

Objects are physical entities that can be obtained and used by the player and are bound by physics.

- Create a scene extending *object/base/BaseObject.tscn*, or one of its decedents, and save it in *object/STRUCTURE_NAME*.
- Populate the `texture` field of "Sprite" with a sprite (that fits in an inventory slot).
- Create a script that extends `BaseObject` (or a descendant). If the object has specific functionality, feel free to write it in the following functions:
  - `equip()` - called when the object is first held
  - `primary()` - called when the primary action key is pressed while the object is being held
  - `secondary()` - called when the secondary action key is pressed while the object is being held
  - `unequip()` - called when the object is no longer being held

## See Also

- [Creating Object Generators](create-generator.md#object-generator)
