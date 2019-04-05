# Tile Map

## Anatomy

As a tile-based game, the most primitive unit of the physical world is the [tile].

## Scene

The [tile map] is a (`TileMap`) scene which holds all tiles in the game. All tiles in the game are created in [TileSet.tscn] and exported to [tile_set.tres], which is used by the tile map.

## Generators

Generators make up the world when it is first created. Currently, there are two types of generators: the terrain generator and structure generators. These both inherit from the base generator--`TileGenerator`. This base generator has an abstract method `process_stack(x)`, which is called when new stack is first *processed*, or recognized as part of the terrain. From there, the generator can do whatever it wants with that event.

The terrain generator generates one stack at a time and post-processes the adjacent stack, on `process_stack`.

Structure generators take a different approach and generate the entire structure at once. Each time `process_stack` is called, a `can_generate(x)` method is called. If the result is `true`, the entire structure is generated with `gen_structure(x)` (`x` is the stack that's being currently processed). See the [structures/tree][tree] for an implementation

## See Also
* [Terrain](terrain.md)
* [Designing a tile](docs/guides/design-tile.md)
* [Designing a structure](docs/guides/design-structure.md)

[tile]: /into-the-woods/map/tiles/base
[tile map]: /into-the-woods/map
[TileSet.tscn]: /into-the-woods/map/TileSet.tscn
[tile_set.tres]: /into-the-woods/map/tile_set.tres
[tree]: /into-the-woods/map/structure/tree
