extends StateMachine.State

const FRAMES = { 
        Vector2.ZERO: 0,
        Vector2.UP: 0,
        Vector2.DOWN: 2,
        Vector2.LEFT: 4,
        Vector2.RIGHT: 1
    }

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
    target.sprite.set_frame(FRAMES[dir])

