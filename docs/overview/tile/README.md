# Tiles

## Anatomy

As a tile-based game, the most primitive unit of the physical world is the [tile]. Different types of features are stored in different layers. Lastly, the [map manager] contains all layers in the game.

## Layers

The tiles for each type of feature is stored in a layer. Each layer is a `TileMap` scene. All the tile templates belonging to the layer are created in a tile set scene and exported to a tile set resource.

## See Also

* [Layers](layer.md)
* [Designing a tile](docs/guides/design-tile.md)

[tile]: /into-the-woods/tile/tiles/base
[map manager]: /into-the-woods/tile
