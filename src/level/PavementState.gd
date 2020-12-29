extends LevelState

const Pavement = preload("res://src/row/Pavement.tscn")

var _type


func start():
    _type = 0

func get_row():
    var row = Pavement.instance()
    row.type = _type
    _type = _get_next_type(_type)
    if _type == null:
        .change_state(_get_next_state())
    return row

func _get_next_type(type):
    if type < 2:
        return type + 1
    else:
        return null


func _get_next_state():
    return "road"
