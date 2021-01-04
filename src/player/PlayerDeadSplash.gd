extends StateMachine.State

func _on_enter(_previous):
    target.sprite.play("splash")
    SoundEffectPlayer.play("splash")
    target.trigger_death()
