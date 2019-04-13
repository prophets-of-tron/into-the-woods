# Designing Tiles

All tiles are scenes that inherit from a base Tile scene. Most terrain tiles have static bodies, while structure tiles do not. Tiles are imported to a tile set, which is used by tile maps in the game.

1. Create a scene, inheriting from *tile/base/tiles/Tile.tscn* (or one of its descendants). If you are creating a terrain tile, inherit from *tile/terrain/tiles/base/SolidTile.tscn* for terrain with static colliders and *TerrainTile.tscn* for others (a.k.a. water). Save it as *tile/terrain/tiles/TILE_NAME/TILE_NAME.tscn* or *tile/structure/PATH_TO_STRUCTURE/tiles/TILE_NAME.tscn* (depending on the type of tile).
2. Add an instance of the scene to the tile set scene in *tile/terrain* or *tile/structure/PATH_TO_STRUCTURE*, and assign a 1 pixel texture to the sprite node.
3. Export the TileSet scene (as a tile set :-) ). Right now, you have to manually set each tiles' region's width and height to 8,8; and, if it has a shape, the shape's (rectangle) bounds to 4,4 and the shape offset to 4,4 for all tiles with collision shapes.
4. Now it can be used in the game!
