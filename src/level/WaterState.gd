extends LevelState

const Water = preload("res://src/row/Water.tscn")
const Log = preload("res://src/row/entity/Log.tscn")


var _type
var _last_velocity = 0

func start():
    _type = 0
    _last_velocity = [-1,1][randi()%2]

func get_row():
    var row = Water.instance()
    row.type = _type
    row.moving_object = Log
    row.velocity = -[1,2][randi()%2]*sign(_last_velocity)
    _last_velocity = row.velocity
    var _new_state = _get_next_state()
    if _new_state != "water":
        .change_state(_new_state)
    _type = _get_next_type(_type)
    return row

func _get_next_type(type):
    return type + 1
  

func _get_next_state():
    if _type == 7 or (_type >= 1 and randf() < 0.5):
        return "dirt"
    else:
        return "water"