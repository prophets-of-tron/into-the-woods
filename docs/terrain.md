# Terrain

## Overview

As a tile-based game, the most primitive unit of terrain is the [tile]. Columns of tiles are called [stacks], and those stacks are laid side-by-side to produce the [terrain].

## Properties

- Terrain stacks resemble literal stacks. There are no caves or overhanging land, so there is only one height value per terrain stack.

## Generation

Procedural generation looks like this:
- **Stack**:
  1. Generate a height for that stack (using [Perlin noise][noise]).
  2. Populate the stack with tiles (for now, just with dirt; but we will [make this more complex][terrain notes] in future updates).
  3. Send `stack_generated` signal to existing stacks. The previous stack will then replace all its dirt tiles that are exposed to air with grass tiles. (If we were to simply turn the top-most tile to grass, than steep hills would look distorted; we will handle cliffs in later updates.)

[tile]: /into-the-woods/terrain/stack/tile
[stacks]: /into-the-woods/terrain/stack
[terrain]: /into-the-woods/terrain
[noise]: /into-the-woods/util/softnoise.gd
[terrain notes]: /into-the-woods/terrain/stack/notes.md
