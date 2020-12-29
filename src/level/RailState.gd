extends LevelState

const Rail = preload("res://src/row/Rail.tscn")

var _type

const NEXT_STATE = ["road", "water"]

func start():
    _type = 0

func get_row():
    var row = Rail.instance()
    row.type = _type
    _type = _get_next_type(_type)
    if _type == null:
        .change_state(_get_next_state())
    return row

func _get_next_type(type):
    if type < 3:
        return type + 1
    else:
        return null

func _get_next_state():
    return NEXT_STATE[randi() % NEXT_STATE.size()]
