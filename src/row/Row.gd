extends Area2D

var type setget set_type

func set_type(new_type):
    type = new_type
    $Sprite.set_frame(type)
    var height = get_height()
    $Sprite.offset.y = -height
    $CollisionShape.position.y = -height / 2


func get_height():
    return $Sprite.frames.get_frame($Sprite.animation, $Sprite.frame).get_height()
