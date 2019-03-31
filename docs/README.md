# Documentation

## Introduction

Welcome to Into the Woods' developer docs! Here we will lay out the basic elements of the game that all contributors should understand. If you are looking for more technical details, see the WIP [game design doc].

## Tile-based Game

This is a tile-based game, meaning that all [terrain] and structures are represented by (square) tiles. Terrain tiles are indestructible and collision-solid, while structure tiles are destructible and collision-free.

## Procedural Generation

The content in this game is generated procedurally. When the player traverses the new 2d landscape, more content is generated and certain parts of the old content is unloaded (such as terrain, which can be regenerated to be exactly the same).

## Component Overviews

- [Autoloaded Scenes]
- [Terrain]
- [Tile Map]

## Guides

- [Creating a tile]
- [Creating a structure]

[game design doc]: /DESIGN.md
[autoloaded scenes]: overview/autoloads.md
[terrain]: overview/map/terrain.md
[tile map]: overview/map/map.md
[creating a tile]: guides/create-tile.md
[creating a structure]: guides/create-structure.md
