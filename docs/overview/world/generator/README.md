# Generators

## Overview

[Generators] are nodes that create procedural content. Generators can currently be broken down into three categories:
- [Terrain generator](/into-the-woods/world/generator/terrain) - creates the terrain
- [Structure generators](/into-the-woods/world/generator/structure) - place structures
- [Object generators](/into-the-woods/world/generator/object) - place objects

## Explanation

Ultimately, all generators work on a stack-by-stack basis. In other words, every generator implements a `init_stack(x)` method, by which content is created. The terrain generator and most object generators implement this directly, while structure generators use it indirectly with `can_generate(x)` and `gen_structure(x)`.

## See Also

- [Terrain Generator](terrain.md)
- [Structure Generators](structure.md)
- [Object Generators](object.md)
- [Creating a Generator](/docs/guides/create-generator.md)

[generators]: /into-the-woods/world/generator
