extends Node

# This signal will be available everywhere in the game
signal shirt_shredded(message)

func _ready():
	print("=== SIGNALBUS LOADED ===")
	print("SignalBus path: ", get_path())
