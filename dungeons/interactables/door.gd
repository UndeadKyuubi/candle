extends StaticBody2D


@export var interactable: Interactable
@export var sprite: Sprite2D
@export var collider: CollisionShape2D
@export var is_last_door: bool = true
@export var starts_locked:bool=true  
@export var Unlock_Sound: AudioStreamPlayer2D

const CLOSED_DOOR_REGION: Rect2 = Rect2(80.0, 368.0, 32.0, 16.0)
const OPEN_DOOR_REGION: Rect2 = Rect2(0.0, 427.0, 32.0, 21.0)
var islocked:bool
func _ready() -> void:
	sprite.region_rect = CLOSED_DOOR_REGION
	interactable.interact = _on_interact
	islocked=starts_locked


func _on_interact() -> void:
	if islocked:
		pass
	else:
		sprite.region_rect = OPEN_DOOR_REGION
		if is_last_door:
			SceneManager.reload_current_scene()
		#SceneManager.transition_to(SceneManager.SCENES.DungeonTutorial)
		
func unlock_door()->void:
	Unlock_Sound.play()
	islocked=false
	
