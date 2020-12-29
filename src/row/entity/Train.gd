extends Area2D


var velocity

func _ready():
    $Sprite.set_animation(str(randi()%3))
    if velocity < 0:
        $Sprite.set_frame(0)
    else:
        $Sprite.set_frame(1)
    

func _physics_process(delta):
    position.x += velocity*60*delta
    if velocity < 0 and position.x < -1000:
        queue_free()
    elif velocity > 0  && position.x > 480 + 1000:
        queue_free()
