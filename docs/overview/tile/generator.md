# Generators

## Overview

Generators are processes that create tiles when a tile stack is first processed. Here is the basic class hierarchy:

```
TileGenerator
+-- TerrainGenerator (unnamed)
+-- StructureGenerator
```

All other generators fall under `StructureGenerator`.

## See Also

* [Creating Structure Generators](docs/guides/design-proc-structure.md)
