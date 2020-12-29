extends StateMachine.State

func _on_enter(_previous):
    target.sprite.set_animation("splat")
    _set_direction_frame(target.direction)
    target.dead = true

func _set_direction_frame(dir):
    if dir == Vector2.UP:
        target.sprite.set_frame(0)
    elif dir == Vector2.DOWN:
        target.sprite.set_frame(2)
    elif dir == Vector2.LEFT:
        target.sprite.set_frame(4)
    elif dir == Vector2.RIGHT:
        target.sprite.set_frame(1)
    