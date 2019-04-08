# Tiles

## Anatomy

As a tile-based game, the most primitive unit of the physical world is the [tile]. Different types of features are stored in different layers. Lastly, the [map manager] contains all layers in the game.

## Layers

The tiles for each type of feature is stored in a layer. Each layer is a `TileMap` scene. All the tile templates belonging to the layer are created in a tile set scene and exported to a tile set resource.

## Generators

Generators make up the world when it is first created. Currently, there are two types of generators: the terrain generator and structure generators. These both inherit from the base generator--`TileGenerator`. This base generator has an abstract method `process_stack(x)`, which is called when new stack is first *processed*, or recognized as part of the terrain. From there, the generator can do whatever it wants with that event.

The terrain generator generates one stack at a time and post-processes the adjacent existing stack, on `process_stack`.

Structure generators take a different approach and generate the entire structure at once. Each time `process_stack` is called, a `can_generate(x)` method is called. If the result is `true`, the entire structure is generated with `gen_structure(x)` (`x` is the stack that's being currently processed). See the [structures/tree][tree structure] for an implementation.

## See Also

* [Layers](layer.md)
* [Generators](generators.md)
* [Terrain](terrain.md)
* [Structures](structure.md)
* [Designing a tile](docs/guides/design-tile.md)
* [Designing a procedural structure](docs/guides/design-proc-structure.md)

[tile]: /into-the-woods/map/tiles/base
[map manager]: /into-the-woods/map
[tree]: /into-the-woods/map/structure/tree
