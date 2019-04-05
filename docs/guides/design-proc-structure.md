# Designing Procedural Structures

Structures are groups of structure tiles that form something recognizable, like a tree or a bush.

1. [Create any tiles][design-tile.md] that compose the structure.
2. Create the generator
  1. Create a node that inherits from *map/structure/generator*.
  2. Attach a script, and implement the `can_generate(x)` and `gen_structure(x)`.
3. Add an instance of the generator to *map/Map.tscn*. Empty nodes can be used as containers, to organize generators.
