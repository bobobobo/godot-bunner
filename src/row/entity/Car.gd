extends Area2D

var velocity
var player = null

var _has_zoomed = false
var _has_honked = false

func _ready():
    if velocity < 0:
        $Sprite.set_animation("left")
    else:
        $Sprite.set_animation("right")
    $Sprite.set_frame(randi()%5)

func _physics_process(delta):
    position.x += velocity*60*delta

    if player != null:
        var y_distance = abs(int(global_position.y - player.global_position.y) - 20) 
        var x_distance = global_position.x - player.global_position.x
                
        if abs(x_distance) < 100 and ((x_distance<=0) != (velocity<=0)):
            if y_distance == 0 and not _has_honked:
                SoundEffectPlayer.play("honk")
                _has_honked = true
            elif abs(y_distance-40) < 5 and abs(velocity)>1 and not _has_zoomed:
                SoundEffectPlayer.play("zoom")
                _has_zoomed = true

    if velocity < 0 and position.x < -120:
        queue_free()
    elif velocity > 0  && position.x > 480 + 120:
        queue_free()
