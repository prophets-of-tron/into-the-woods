# Chunks

## Overview

Chunks break the game up into groups of consecutive stacks of tiles. They make loading and unloading more efficient and easier. Each chunk is a `TileMap` node, whose tiles make up its terrain and structures.

## Generation

When generating, every chunk uses the following root nodes:
- **/root/World/Generators/TerrainGenerator** - for populating the tile map with [terrain] tiles

[terrain]: terrain.md
