extends CanvasLayer

func _ready():
	print("=== CHECKING ALL UI NODES ===")
	
	# List all direct children of the UI node
	for child in get_children():
		print("Child node: ", child.name, " (Type: ", child.get_class(), ")")
	
	# Also try to get the specific nodes we need
	print("Trying to find ShredMessage: ", get_node_or_null("ShredMessage"))
	print("Trying to find MoneyLabel: ", get_node_or_null("MoneyLabel"))
	
	print("=== END NODE CHECK ===")
