extends OmniLight3D
@onready var player= $"../../../Player"
@onready var KeyPos=$"../../../hangingKey"
@onready var DKey=$"../KeyShadowMesh"

const SCALE:float =2.0 / 180.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var offset = player.global_position - KeyPos.global_position
	position=Vector3(DKey.position.x + offset.x * SCALE,0.0, DKey.position.z + offset.y * SCALE)
