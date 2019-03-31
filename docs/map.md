# Tile Map

## Anatomy

As a tile-based game, the most primitive unit of terrain is the [tile]. Columns of tiles are called stacks. Stacks are laid side-by-side to produce the terrain. Note that the tilemap contains all tiles in the game. Stacks only describe *the order in which the tiles are generated*.

## Scene

The [tile map] is a (`TileMap`) scene which holds all tiles in the game. All tiles in the game are created in [TileSet.tscn] and exported to [tile_set.tres], which is used by the tile map.

## See Also
* [Terrain](terrain.md)

[tile]: /into-the-woods/tiles/terrain/tile
[tile map]: /into-the-woods/tiles
[TileSet.tscn]: /into-the-woods/tiles/TileSet.tscn
[tile_set.tres]: /into-the-woods/tiles/tile_set.tres
