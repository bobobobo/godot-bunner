extends StateMachine.State

func _on_enter(_previous):
    target.sprite.play("splash")
    target.dead = true
