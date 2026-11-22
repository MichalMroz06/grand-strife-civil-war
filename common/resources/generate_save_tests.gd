@tool
extends EditorScript

func _run() -> void:
	var test_item = GameSave.new()
	
	var path = "user://saves/test.tres"
	
	var error = ResourceSaver.save(test_item, path)
	if error == OK:
		print("Succesfully generated test save file in: ", path)
		EditorInterface.get_resource_filesystem().scan()
	else:
		print("Error in generating save file: ", error)
