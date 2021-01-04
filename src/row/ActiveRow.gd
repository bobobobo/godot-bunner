class_name ActiveRow
extends "res://src/row/Row.gd"

var moving_object
var velocity
var _next_obj_timer
var _moving_objects = []

func _ready():
    sound = "road"
    _next_obj_timer = 0
    var x = -480 / 2 - 138
    while x < 480 / 2 + 138:
        x += (240 + (randi() % 241))
        var pos = 480 / 2 + (x if velocity > 0 else -x)  
        _add_moving_object(pos)

func _process(delta):
    _next_obj_timer -= delta
    if _next_obj_timer < 0:
        var pos = 480 + 138 if velocity < 0 else -138
        _add_moving_object(pos)
        _next_obj_timer = (1.0 + randf()) * (240.0 / abs(velocity*60.0))


func _add_moving_object(pos):
    var obj = moving_object.instance()
    obj.velocity = velocity
    obj.position.x = pos
    if "player" in obj:
        obj.player = self.player
    add_child(obj)
