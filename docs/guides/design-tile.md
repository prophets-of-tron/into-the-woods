# Designing Tiles

All tiles are scenes that inherit from a base Tile scene. Most terrain tiles have static bodies, while structure tiles do not. Tiles are imported to a tile set, which is used by tile maps in the game.

1. Create a scene, inheriting from *map/tiles/base/Tile.tscn* (or one of its descendants). If you are creating a terrain tile, inherit from *map/terain/tiles/base/LandTile.tscn* for terrain with static colliders and *FluidTile.tscn* for fluid physics (water). Save it in *map/terrain/tiles* or *map/structure/structure_name/tiles* (depending on the type of tile).
2. Add an instance of the scene to *map/TileSet.tscn*, and assign a 1 pixel texture to the sprite node.
3. Export the TileSet scene (as a tile set) to *map/tile_set.tres*. Right now, you have to manually set the region's width and height to 8 and 8, and, if it has a shape, the shape's (rectangle) bounds to 4,4 and the shape offset to 4,4 for all tiles with collision shapes.
4. Now it can be used in generator algorithms!
