# Generators

## Overview

Generators are nodes that create procedural content. Generators can currently be broken down into three categories:
- [Terrain generator](/into-the-woods/generator/terrain) - creates the terrain
- [Structure generators](/into-the-woods/generator/structure) - place structures
- [Object generators](/into-the-woods/generator/object) - place objects

## Explanation

Ultimately, all generators work on a stack-by-stack basis. In other words, every generator implements a `process_stack(x)` method, by which content is created. The terrain generator and most object generators implement this directly, while structure generators use it indirectly with `can_generate(x)` and `gen_structure(x)`.

## See Also
- [Terrain generator](terrain.md)
- [Structure generators](structure.md)
- [Object generators](object.md)
