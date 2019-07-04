# Designing Generators

## Overview

Generators place content on the world when it is *first* created. The general workflow of designing one is as follows:

1. Create a node that inherits from *generator/base/Generator.tscn* or one of its decedents.
2. Write the generator script that extends from the extended scene's script.
3. Add an instance of the generator to **GeneratorManager.tscn**. *Note: regular `Node`s can be used as containers to organize the generators.*

## Object Generator

1. Create a node that inherits from *generator/object/base/ObjectGenerator.tscn*, and save it in *generator/object/OBJECT_NAME*.
2. Attach a script that inherits from `ObjectGenerator` and implements `init_stack(x)`.
  - To create an object:
    - Create an instance of the object's scene.
    - Set its position (and flip the y-axis, because all tile layers are flipped vertically; also remember to convert from tile grid space to world space).
    - Call `ObjectGenerator#objects.add_child` to add the instance to the game.
    - Emit an `object_generated` signal.
3. Add an instance of your new generator to **GeneratorManager.tscn**/Object.

## Structure Generator

1. Create a node that inherits from *generator/structure/base/StructureGenerator.tscn*, and save it in *generator/structure/LAYER_NAME/STRUCTURE_NAME* or just *generator/structure/STRUCTURE_NAME*, depending on the structure.
2. Attach a script that extends `StructureGenerator`, and implement `can_generate(x)` and `gen_structure(x)`.
  - To create a structure (in `gen_structure`)
    - Create an instance of the object's scene.
    - Set its position (and flip the y-axis, because all tile layers are flipped vertically; also remember to convert from tile grid space to world space).
    - Call `StructureGenerator#structures.add_child` to that instance.
    - Redirect all `Structure#structure_tile_generated` signal emissions to the generator's `structure_tile_generated` signal, by connecting to `StructureGenerator#_on_Structure_structure_tile_generated`:

    ```gdscript
    instance.connect("structure_tile_generated", "_on_Structure_structure_tile_generated")
    ```

    - Populate the corresponding layer with the tiles of the structure, by calling `place_tiles(layer)` on the structure.
    - Call `StructureGenerator#structures.add_child` to add the instance to the game.
    - Emit a `structure_gneerated` signal.
