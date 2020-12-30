extends Node2D

func _process(delta):
   position.y += 550 * delta
   if position.y > 950:
        queue_free()
