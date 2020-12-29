extends LevelState

const Road = preload("res://src/row/Road.tscn")
const Car = preload("res://src/row/entity/Car.tscn")



var _type
var _velocities
var _last_velocity

func start():
    _type = 0
    _velocities = []
    _last_velocity = 0
    for i in range(-5, 6):
        _velocities.append(i)
    _velocities.erase(0)

func get_row():
    var row = Road.instance()
    row.type = _type
    var v = Array(_velocities)
    v.erase(_last_velocity)
    row.velocity = v[randi() % v.size()]
    _last_velocity = row.velocity
    row.moving_object = Car
    
    var _new_state = _get_next_state()
    if _new_state != "road":
        .change_state(_new_state)
    _type = _get_next_type(_type)
    return row

func _get_next_type(type):
    if type < 5:
        return type + 1
    else:
        return null

func _get_next_state():
    if _type == 0:
        return "road"
    elif _type < 5:
        var r = randf()
        if r < 0.8:
            return "road"
        elif r < 0.88:
            return "grass"
        elif r < 0.94:
            return "rail"
        else:
            return "pavement"
    else:
        var r = randf()
        if r < 0.6:
            return "grass"
        elif r < 0.9:
            return "rail"
        else:
            return "pavement"
