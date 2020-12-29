extends Area2D

func set_tile(x,y):
    $Sprite.set_animation(str(x))
    $Sprite.set_frame(y)

    var height = get_height()
    $Sprite.offset.y = -height


func get_height():
    return $Sprite.frames.get_frame($Sprite.animation, $Sprite.frame).get_height()
    
