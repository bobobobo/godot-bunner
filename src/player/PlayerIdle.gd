extends StateMachine.State

const INPUTS = {"ui_right": Vector2.RIGHT,
            "ui_left": Vector2.LEFT,
            "ui_up": Vector2.UP,
            "ui_down": Vector2.DOWN}

var timer = 0

func _on_enter(_previous):
    target.sprite.set_animation("sit")
    _set_direction_frame(target.direction)

func _unhandled_input(event):
    for dir in INPUTS.keys():
        if event.is_action_pressed(dir):
            move(INPUTS[dir])

func move(dir):
    target.ray.cast_to = dir * 40
    target.ray.force_raycast_update()
    if !target.ray.is_colliding():
        target.direction = dir
        state_machine.transition("jump")

func _physics_process(_delta):
    target.position.x = max(16, min(480 - 16, target.position.x))
    if target.is_on_water() and not target.is_on_log():
        state_machine.transition("dead/splash")
    if target.is_hit_by_car() or target.is_hit_by_train():
        state_machine.transition("dead/splat")

func _set_direction_frame(dir):
    if dir == Vector2.UP:
        target.sprite.set_frame(0)
    elif dir == Vector2.DOWN:
        target.sprite.set_frame(2)
    elif dir == Vector2.LEFT:
        target.sprite.set_frame(4)
    elif dir == Vector2.RIGHT:
        target.sprite.set_frame(1)
