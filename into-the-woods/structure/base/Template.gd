extends TileMap

signal structure_tile_generated(tile, x, y)

# must only contain integer values
export(Rect2) var bounds

func place_tiles(layer, x, y):
	for sample_x in range(bounds.position.x, bounds.end.y):
		for sample_y in range(bounds.position.y, bounds.end.y):
			var sample = get_cell(sample_x, sample_y)
			# if greater than -1
			if sample > TileMap.INVALID_CELL:
				var world_x = x + sample_x
				var world_y = y - sample_y
				# flip y-axis (TODO it's gross, think about this)
				layer.set_cell(world_x, world_y, sample)
				emit_signal("structure_tile_generated", sample, world_x, world_y)
