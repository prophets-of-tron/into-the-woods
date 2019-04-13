# Structure Generators

Structure generators place [structures] procedurally. To make things easier, structures are placed as entire structures, not stack by stack. To do this, every structure generator implements `can_generate(x)` and `gen_structure(x)` methods, which determine where and how structures of generated, respectively. To understand how these methods are used, here is what `StructureGenerator#process_stack` looks like:

```gdscript
func process_stack(x):
	if can_generate(x):
		gen_structure(x)
```

Thus, `can_generate` returns `true` when a structure based at `x` should be generated, and `gen_structure` creates the entire structure.
