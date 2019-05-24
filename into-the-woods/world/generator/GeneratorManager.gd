extends Node
class_name GeneratorManager

var generators = []
var left = +INF
var right = -INF

# traverses hierarchy and collects generators
# each generator is a node
func _register_generators(node:Node):
	if node.get_child_count() > 0:	# redundent but for readability
		for child in node.get_children():
			_register_generators(child)	# our dear friend recursion
	var gen = node as Generator
	if gen == null:
		# give them the benefit of the doubt; it's a container node
		return
	
	generators.append(gen)

func _ready():
	_register_generators(self)
	
	# Generate a single stack at x=0, because Player#check_load
	# only generates to the left and right of x=0
	process_stack(0)

func process_stack(x):
	if is_stack_processed(x):
		print("[WARN] Probably shouldn't be re-processing stack@x="+str(x))
		# already generated
		return
		
	for generator in generators:
		generator.process_stack(x)

	left = min(left, x)
	right = max(right, x)

func is_stack_processed(x):
	return x >= left and x <= right
