extends Node2D


const Player = preload("res://src/player/Player.tscn")
const Eagle = preload("res://src/level/Eagle.tscn")
const GrassState = preload("res://src/level/GrassState.gd")
const RoadState = preload("res://src/level/RoadState.gd")
const WaterState = preload("res://src/level/WaterState.gd")
const DirtState = preload("res://src/level/DirtState.gd")
const PavementState = preload("res://src/level/PavementState.gd")
const RailState = preload("res://src/level/RailState.gd")

var y = 800

var states
var active_state: LevelState

var last_added_row 

var player
var eagle

signal game_over

func _ready():
    start(false)

func start(with_player):
    if player != null:
        player.queue_free()

    if with_player:
        player = Player.instance()
        player.connect("died", self, "_on_Player_died")
        add_child(player)
        player.position = Vector2(240, 800-320-20)


    y = 800
    eagle = null
    last_added_row = null
    randomize()
    states = {
        "grass": _create_state(GrassState),
        "road": _create_state(RoadState),
        "water": _create_state(WaterState),
        "dirt": _create_state(DirtState),
        "pavement": _create_state(PavementState),
        "rail": _create_state(RailState),
    }
    change_state("grass")
    active_state._type = 0
    for child in $Rows.get_children():
        child.queue_free()
    _generate_rows()
   
func change_state(new_state):
    if new_state in states:
        active_state = states[new_state]
        active_state.start()
    else:
        active_state = null

func _on_Player_died():
    yield(get_tree().create_timer(2.0), "timeout")
    emit_signal("game_over")

func _trigger_eagle():
    eagle = Eagle.instance()
    eagle.position = Vector2(player.position.x, -50)
    add_child(eagle)
    eagle.connect("tree_exited", self, "_on_Eagle_exited")

func _on_Eagle_exited():
    emit_signal("game_over")

func _create_state(state_class):
    var state = state_class.new()
    state.level = self
    return state

func _generate_rows():
    while active_state != null and y>=-40:
        var row = active_state.get_row()
        row.position.y = y
        y -= 40
        $Rows.add_child(row)
        $Rows.move_child(row, 0)
        last_added_row = row

func _physics_process(delta):
    for row in $Rows.get_children():
        row.position.y += 60 * delta
        if row.position.y > 860:
            row.queue_free()
    if last_added_row.position.y >= 0:
        y = last_added_row.position.y - 40
        _generate_rows()

    if player != null:
        player.position.y += 60 * delta

        if player.position.y > 850 and eagle == null:
            _trigger_eagle()

