extends CharacterBody2D
class_name Player

#region exports
@export_group("Nodes")
#@export var animated_sprite: AnimatedSprite2D
#@export var cha
@export var wax_bar: ProgressBar
@export var candle: Sprite2D
@export var flame: Sprite2D
@export_group("")

@export_group("Feel")
@export var speed: float = 100.0
@export_group("")
#endregion

@onready var foreground_layer: TileMapLayer = $"../Foreground"

#region state
var input_dir: Vector2 = Vector2.ZERO
var heat_scale:float=.8 
var knockback=Vector2.ZERO

var rotate_time: float = 0.0

var wax: float = 10.0:
	set(val):
		wax = val
		_update_wax_ui()
#endregion

func _ready() -> void:
	wax_bar.max_value = wax

func _physics_process(delta: float) -> void:
	input_dir = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_just_released("scroll_up") and heat_scale<1.1:
		heat_scale+=.05
	if Input.is_action_just_released("scroll_down") and heat_scale>0.1:
		heat_scale-=.05
	
	_handle_animations(delta)
	
	wax -= .1*delta*heat_scale
	velocity = input_dir.normalized() * speed+knockback
	
	move_and_slide()
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		if body != null and body.is_in_group("enemies"):
			take_damage(body.global_position)
			
	check_tile()
			
	knockback=lerp(knockback,Vector2.ZERO, 0.1)
	if wax<=0.0:
		SceneManager.reload_current_scene()
		
func check_tile() -> void:
	var map_position: Vector2i = foreground_layer.local_to_map(foreground_layer.to_local(global_position))
	var tile: TileData = foreground_layer.get_cell_tile_data(map_position)
	
	if tile and tile.get_custom_data("is_trigger"):
		trigger_tile(map_position)
		
func trigger_tile(map_position: Vector2i) -> void:
	foreground_layer.set_cell(map_position, -1)
	var door = get_node_or_null("../Door")
	
	if door and door.has_method("_unlock"):
		door._unlock()

func _handle_animations(delta) -> void:
	if input_dir != Vector2.ZERO:
		rotate_time = wrapf(rotate_time + (delta * 20.0), 0, 20.0 * 10)
		candle.rotation = sin(rotate_time) * deg_to_rad((-18.0) * sign(input_dir.x if input_dir.x != 0 else 1.0))
	else:
		rotate_time = 0.0
		candle.rotation = lerp(candle.rotation, 0.0, delta * 10)

func _update_wax_ui() -> void:
	wax_bar.value = wax
	flame.scale=Vector2.ONE*heat_scale
	
func take_damage(enemypos)->void:
	wax-=3
	knockback=(enemypos.direction_to(global_position))*400
