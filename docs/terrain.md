# Terrain

## Overview

As a tile-based game, the most primitive unit of terrain is the [tile]. Columns of tiles are called stacks. Stacks are laid side-by-side to produce the terrain. Note that a [tilemap] contains all tiles in the game. Stacks only describe *the order in which the tiles are generated*.

## Properties

- Terrain stacks resemble literal stacks. There are no caves or overhanging land, so there is only one height value per terrain stack.

## Generation

Procedural generation looks like this:
- **Stack**:
  1. Generate a height for that stack (using [Perlin noise][noise]).
  2. Populate the stack with tiles (for now, just with dirt; but we will [make this more complex][terrain notes] in future updates). For each tile, emit a `tile_generated` signal.
  3. Notify the previous stack of the generation, who replaces all its dirt tiles that are exposed to air with grass tiles. (If we were to simply turn the top-most tile to grass, than steep hills would look weird; we will handle cliffs in later updates.)
  4. Emit a `stack_generated` signal.
- **Terrain**:
  - Generate stacks around the player as he moves.

[tile]: /into-the-woods/tiles/terrain/tile
[tilemap]: /into-the-woods/tiles
[noise]: /into-the-woods/util/softnoise.gd
[terrain notes]: /into-the-woods/tiles/terrain/notes.md
