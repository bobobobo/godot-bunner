extends Area2D


var velocity
var entities = []

func _ready():
    var type = randi()%2
    $Sprite.set_frame(type)

    $CollisionShapeSmall.disabled = type != 0
    $CollisionShapeLarge.disabled = type != 1
    

func _physics_process(delta):
    position.x += velocity*60*delta
    for entity in entities:
        if entity.get("dead") == true:
            continue
        entity.position.x += velocity*60*delta
    if velocity < 0 and position.x < -160:
        queue_free()
    elif velocity > 0  && position.x > 480 + 160:
        queue_free()

    
func _on_Log_area_entered(area):
    entities.append(area)

func _on_Log_area_exited(area):
    entities.erase(area)
    
           
