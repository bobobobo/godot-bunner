extends LevelState

const Dirt = preload("res://src/row//Dirt.tscn")
const NEXT_STATE = ["road", "water"]

var _type

func start():
    _type = 4 + randi() % 3

func get_row():
    var row = Dirt.instance()
    row.type = _type
    _type = _get_next_type(_type)
    if _type == null:
        .change_state(_get_next_state())
    return row

func _get_next_type(type):
    if type <= 5:
        return type + 8
    elif type == 6:
        return 7
    elif type == 7:
        return 15
    elif type >= 8 and type <= 14:
        return type + 1
    else:
        return null

func _get_next_state():
    return NEXT_STATE[randi() % NEXT_STATE.size()]
    
