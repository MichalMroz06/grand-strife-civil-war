extends Control

@onready var current_size_lbl: Label = $horizontal_container/vertical_container/header_container/horizontal_container/current_size_lbl
@onready var collapse_expand_btn: TextureButton = $horizontal_container/vertical_container/header_container/horizontal_container/collapse_expand_btn
@onready var list_container: PanelContainer = $horizontal_container/vertical_container/list_container
@onready var vertical_container: VBoxContainer = $horizontal_container/vertical_container/list_container/vertical_container
@onready var option_1_btn: TextureButton = $horizontal_container/vertical_container/list_container/vertical_container/option_1_btn


@export var resolutions: Array[Vector2i] = [
	Vector2i(1280, 720),
	Vector2i(1920, 1080),
	Vector2i(2560, 1440),
	Vector2i(3840, 2160)
]

@export var texture_arrow_closed: Texture2D
@export var texture_arrow_opened: Texture2D

func _ready() -> void:
	current_size_lbl.text = "%dx%d" % [Settings.current_resolution.x, Settings.current_resolution.y]
	
	generate_resolution_list()
	
	option_1_btn.visible = false
	
	list_container.visible = false
	update_toggle_texture()


func _on_collapse_expand_btn_pressed() -> void:
	list_container.visible = !list_container.visible
	update_toggle_texture()

func generate_resolution_list() -> void:
	for res in resolutions:
		var res_string = "%d x %d" % [res.x, res.y]
		
		var new_btn: TextureButton = option_1_btn.duplicate() as TextureButton
		new_btn.visible = true
		
		var btn_label: Label = new_btn.get_node_or_null("option_1_btn_lbl")
		if btn_label:
			btn_label.text = res_string
		
		vertical_container.add_child(new_btn)
		
		new_btn.pressed.connect(on_resolution_selected.bind(res, res_string))


func on_resolution_selected(new_res: Vector2i, res_string: String) -> void:
	current_size_lbl.text = res_string
	
	Settings.current_resolution = new_res
	Settings.apply_settings()
	Settings.save_settings()
	
	list_container.visible = false
	update_toggle_texture()


func update_toggle_texture() -> void:
	if texture_arrow_closed and texture_arrow_opened:
		if list_container.visible:
			collapse_expand_btn.texture_normal = texture_arrow_opened
		else:
			collapse_expand_btn.texture_normal = texture_arrow_closed
