extends Area2D

var velocity

func _ready():
    if velocity < 0:
        $Sprite.set_animation("left")
    else:
        $Sprite.set_animation("right")
    $Sprite.set_frame(randi()%5)

func _physics_process(delta):
    position.x += velocity*60*delta
    if velocity < 0 and position.x < -120:
        queue_free()
    elif velocity > 0  && position.x > 480 + 120:
        queue_free()
