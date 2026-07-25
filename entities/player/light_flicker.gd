extends PointLight2D

var light_energy: float = 1.0
var flicker: float = 0.8

var desired_energy: float = 1.0
var time_passed: float = 0.0
var flicker_speed: float = 0.2
var fade_speed: float = 7.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta
	
	if time_passed >= flicker_speed:
		desired_energy = light_energy + randf_range(-flicker, 0.0)
		time_passed = 0.0
		
	energy = lerp(energy, desired_energy, fade_speed * delta)
