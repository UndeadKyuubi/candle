extends StaticBody2D
class_name Cobweb

@export var interactable: Interactable
@export var fire_woosh: AudioStreamPlayer

var on_fire: bool = false

func _ready() -> void:
	interactable.interact = set_on_fire

func set_on_fire() -> void:
	if on_fire:
		return
	
	on_fire = true
	var tween: Tween = create_tween()
	
	# TODO: add audio manager
	fire_woosh.pitch_scale = randf_range(0.7, 1.3)
	fire_woosh.volume_linear = 0.1
	fire_woosh.play()
	
	tween.tween_property(self, "modulate", Color(1.0, 0.8, 0.0, 1), 0.1)
	tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.0, 0.0), 0.1)
	
	tween.tween_callback(func() -> void:
		for area in interactable.get_overlapping_areas():
			var parent = area.get_parent()
			if parent is Cobweb and parent.has_method("set_on_fire"):
				parent.set_on_fire()
	)
	
	await fire_woosh.finished
	
	#if fire_woosh.playing:
		#process_mode = PROCESS_MODE_DISABLED
		#hide()
		#
		#fire_woosh.get_parent().remove_child(fire_woosh)
		#get_tree().current_scene.add_child(fire_woosh)
		#
		#fire_woosh.finished.connect(fire_woosh.queue_free)
	#
	queue_free()
