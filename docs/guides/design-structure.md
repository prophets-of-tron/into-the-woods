# Designing Structures

## Procedure

Structures are groups of structure tiles that can be interacted with as an entire entity.

1. Create a scene extending *structure/base/Structure.tscn*, or one of its decedents, and save it in *structure/LAYER_NAME/STRUCTURE_NAME* (LAYER_NAME may be omitted, depending on the structure).
2. Create a tile set, storing all the tiles in a local **TileSet.tscn**, exported to a **TileSet.tres**. Set the *CustomTileMap* node of your structure scene to use that tile set, and design away.
- Note that procedural structures (as in structures whose content is created procedurally) are not currently implemented.

## See Also

- [Creating Tiles](design-tile.md)
- [Creating Structure Generators](create-generator.md#structure-generator)
