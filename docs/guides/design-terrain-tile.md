# Designing Tiles

All tiles are scenes that inherit from a base Tile scene. Most terrain tiles have static bodies, while structure tiles do not. Tiles are imported to a tile set, which is used by tile maps in the game.

1. Create a scene, inheriting from *terrain/base/Tile.tscn* (or one of its descendants). Use *SolidTile.tscn* for terrain with static colliders and *TerrainTile.tscn* for others (a.k.a. water), and save it as *terrain/TILE_NAME/TILE_NAME.tscn*.
2. Add an instance of the scene to the tile set scene in *terrain*, and assign a 1 pixel texture to the sprite node.
3. Export (Scene -> Convert To -> TileSet) the TileSet scene to `./TileSet.tscn`. Right now, you have to manually set each tile's region's width and height to 4,4; and, if it should have collision, set the shape to a "New RectangleShape2D" with bounds 2,2 and the shape offset 4,4.
4. Now it can be used in the game! To do so, declare an int property with a reference to the tile type (using `TileSet#find_tile_by_name`) in the [TerrainInfo script](/into-the-woods/world/info/terrain/TerrainInfo.gd), and then modify [TerrainGenerator.gd](/into-the-woods/world/generator/terrain/TerrainGenerator.gd) to use your new tile(s).
