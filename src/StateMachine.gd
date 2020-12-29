extends Resource

class_name StateMachine

var states = {}
var target: Node setget set_target

var _state: State = State.new()
var _previous_state: State

var DEBUG = false

func _ready():
    pass

func get_state():
    if _state != null:
        return _state.id
    return null

func set_target(new_target):
    target = new_target
    for state in states:
        states[state].target = new_target

func add_state(name, state):
    state.target = target
    state.state_machine = self
    state.id = name
    states[name] = state
    
func transition(new_state):
    if !new_state in states:
        print("Invalid state")
        return
    if DEBUG:
        print(new_state)
    call_deferred("_enter_state", new_state)
 

func _enter_state(new_state):
    _previous_state = _state
    _state = states[new_state]
    if _previous_state != null:
        if(_previous_state.has_method("_on_exit")):
            _previous_state._on_exit(_state.id)
    
    if(_state.has_method("_on_enter")):
        _state._on_enter(_previous_state.id)

func _process(delta):
    if _state == null:
        return
        
    if _state.has_method("_process"):
        _state._process(delta)

func _physics_process(delta):
    if _state == null:
        return

    if _state.has_method("_physics_process"):
        _state._physics_process(delta)

func _unhandled_input(event):
    if _state == null:
        return

    if _state.has_method("_unhandled_input"):
        _state._unhandled_input(event)

class State extends Resource:
    var id
    var target: Node

    var state_machine: StateMachine
