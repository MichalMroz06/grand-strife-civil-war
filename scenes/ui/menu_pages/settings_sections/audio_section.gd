extends Control

@onready var master_slider: HSlider = $container/vertical_container/master_volume/horizontal_container/horizontal_slider
@onready var current_master_volume_lbl: Label = $container/vertical_container/master_volume/horizontal_container/current_master_volume_lbl

@onready var music_slider: HSlider = $container/vertical_container/music_volume/horizontal_container/horizontal_slider
@onready var current_music_volume_lbl: Label = $container/vertical_container/music_volume/horizontal_container/current_music_volume_lbl

@onready var sfx_slider: HSlider = $container/vertical_container/sfx_volume/horizontal_container/horizontal_slider
@onready var current_sfx_volume_lbl: Label = $container/vertical_container/sfx_volume/horizontal_container/current_sfx_volume_lbl

func _ready() -> void:
	master_slider.value = Settings.get_bus_volume(Settings.BUS_MASTER) * 100
	current_master_volume_lbl.text = str(int(master_slider.value)) + "%"
	
	music_slider.value = Settings.get_bus_volume(Settings.BUS_MUSIC) * 100
	current_music_volume_lbl.text = str(int(music_slider.value)) + "%"
	
	sfx_slider.value = Settings.get_bus_volume(Settings.BUS_SFX) * 100
	current_sfx_volume_lbl.text = str(int(sfx_slider.value)) + "%"

func _on_master_volume_changed(value: float) -> void:
	current_master_volume_lbl.text = str(int(master_slider.value)) + "%"
	Settings.set_bus_volume(Settings.BUS_MASTER, value / 100)
	Settings.save_settings()

func _on_music_volume_changed(value: float) -> void:
	current_music_volume_lbl.text = str(int(music_slider.value)) + "%"
	Settings.set_bus_volume(Settings.BUS_MUSIC, value / 100)
	Settings.save_settings()

func _on_sfx_volume_changed(value: float) -> void:
	current_sfx_volume_lbl.text = str(int(sfx_slider.value)) + "%"
	Settings.set_bus_volume(Settings.BUS_SFX, value / 100)
	Settings.save_settings()
