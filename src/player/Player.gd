extends Area2D

const PlayerIdle = preload("res://src/player/PlayerIdle.gd")
const PlayerJump = preload("res://src/player/PlayerJump.gd")
const PlayerDeadSplash = preload("res://src/player/PlayerDeadSplash.gd")
const PlayerDeadSplat = preload("res://src/player/PlayerDeadSplat.gd")



var speed = 0.15
var direction = Vector2.ZERO
var _on_water = 0
var _car_hit = 0
var _train_hit = 0
var dead = false
var state_machine = StateMachine.new()

onready var sprite = $Sprite
onready var ray = $RayCast2D

signal died

func _ready():
    state_machine.target = self
    state_machine.add_state("idle", PlayerIdle.new())
    state_machine.add_state("jump", PlayerJump.new())
    state_machine.add_state("dead/splash", PlayerDeadSplash.new())
    state_machine.add_state("dead/splat", PlayerDeadSplat.new())
    state_machine.transition("idle")


func _unhandled_input(event):
    state_machine._unhandled_input(event)

func _physics_process(delta):
    state_machine._physics_process(delta)

func is_on_log():
    for area in get_overlapping_areas():
        if area.get_collision_layer_bit(3):
            return true
    return false

func is_on_water():
    return _on_water > 0

func is_hit_by_car():
    return _car_hit > 0

func is_hit_by_train():
    return _train_hit > 0

func _on_Player_area_entered(area):
    if area.get_collision_layer_bit(1):
        _on_water += 1
    if area.get_collision_layer_bit(2):
        _car_hit += 1
    if area.get_collision_layer_bit(6):
        _train_hit += 1

func _on_Player_area_exited(area):
    if area.get_collision_layer_bit(1):
        _on_water -= 1
    if area.get_collision_layer_bit(2):
        _car_hit -= 1     
    if area.get_collision_layer_bit(6):
        _train_hit -= 1

func trigger_death():
    dead = true
    emit_signal("died")
