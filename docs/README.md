# Documentation

## Introduction

Welcome to Into the Woods' developer docs! Here we will lay out the basic elements of the game that all contributors should understand. If you are looking for more design details, see the WIP [game design doc].

## Conventions Used in these Docs

All links found in the body of a page point to game files, while those found at the bottom (in "See Also", for instance) point to other doc files.

## Core Components

Terrain tiles, structures and objects, along with the player, make up the game world. Terrain is composed of [terrain tiles][terrain] which are static with collisions, [structures] are static with no collisions, and [objects] have physics with collisions.

## Procedural Generation

The content in this game is generated procedurally. Specifically, as the player traverses the new 2d landscape, more content is generated and certain parts of the old content is unloaded (such as terrain, which can be regenerated to be exactly the same).

## Where to Go from Here

### Component Overviews

- [Player]
- [Info nodes]
- [Terrain]
- [Sprites]
- [Structures]
- [Objects]
- [Generators]

### Other Overviews
- [Autoloaded Scenes]
- [User Input]

### Guides

- [Designing an Info Node]
- [Designing a Terrain Tile]
- [Designing an Object]
- [Designing a Structure]
- [Creating a Procedural Generator]

[game design doc]: /DESIGN.md

[player]: overview/world/player
[info nodes]: overview/world/info
[terrain]: overview/world/terrain
[sprites]: overview/world/sprite
[structures]: overview/world/structure
[objects]: overview/world/object
[generators]: overview/world/generator

[autoloaded scenes]: overview/autoloads.md
[user input]: overview/input.md

[designing an info node]: guides/create-info.md
[designing a terrain tile]: guides/design-terrain-tile.md
[designing an object]: guides/design-object.md
[designing a structure]: guides/design-structure.md
[creating a procedural generator]: guides/create-generator.md
