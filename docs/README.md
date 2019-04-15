# Documentation

## Introduction

Welcome to Into the Woods' developer docs! Here we will lay out the basic elements of the game that all contributors should understand. If you are looking for more design details, see the WIP [game design doc].

## Tile-based Game

This is a tile-based game, meaning that all terrain and structures are represented by tiles. Terrain tiles are indestructible and usually collision-solid, while structure tiles are interactable and collision-free.

## Procedural Generation

The content in this game is generated procedurally. When the player traverses the new 2d landscape, more content is generated and certain parts of the old content is unloaded (such as terrain, which can be regenerated to be exactly the same).

## Where to Go from Here

### Component Overviews

- [Autoloaded Scenes]
- [Player]
- [Info nodes]
- [Tile maps]
- [Structures]
- [Objects]
- [Generators]

### Guides

- [Designing an Info Node]
- [Designing a Tile]
- [Designing an Object]
- [Designing a Structure]
- [Creating a Procedural Generator]

[game design doc]: /DESIGN.md

[autoloaded scenes]: overview/autoloads.md
[player]: overview/player
[info nodes]: overview/info
[tile maps]: overview/tile
[structures]: overview/structure
[objects]: overview/object
[generators]: overview/generator

[designing an info node]: guides/create-info.md
[designing a tile]: guides/design-tile.md
[designing an object]: guides/design-object.md
[designing a structure]: guides/design-structure.md
[creating a procedural generator]: guides/create-generator.md
