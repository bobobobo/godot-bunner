extends Node2D

func _ready():
   SoundEffectPlayer.play("eagle")

func _process(delta):
   position.y += 550 * delta
   if position.y > 950:
        queue_free()
