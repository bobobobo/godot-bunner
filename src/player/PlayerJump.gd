extends StateMachine.State

var timer = 0

func _on_enter(_previous):
    target.sprite.set_animation("jump")
    _set_direction_frame(target.direction)
    timer = target.speed

func _physics_process(delta):
    if timer > 0:
        target.position += target.direction * (40.0/target.speed) * delta
        timer -= delta
    else:
        state_machine.transition("idle")
    
    target.position.x = max(16, min(480 - 16, target.position.x))

func _set_direction_frame(dir):
    if dir == Vector2.UP:
        target.sprite.set_frame(0)
    elif dir == Vector2.DOWN:
        target.sprite.set_frame(2)
    elif dir == Vector2.LEFT:
        target.sprite.set_frame(4)
    elif dir == Vector2.RIGHT:
        target.sprite.set_frame(1)
