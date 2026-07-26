
extends Area2D


@export var door:StaticBody2D

func _on_shadow_unlock_zone_body_entered(body:Node2D)->void:
	if body.name=="Player":
		if door.islocked:
			door.unlock_door()
