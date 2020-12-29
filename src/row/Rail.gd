extends "res://src/row/Row.gd"

const Train = preload("res://src/row/entity/Train.tscn")
const VELOCITIES = [-20, 20]
onready var trains = $Trains

func _process(_delta):
    if self.type == 1 and trains.get_children().size() == 0 and randf() < 0.01 and position.y > 0:
        var velocity = VELOCITIES[randi() % VELOCITIES.size()]
        var train = Train.instance()
        train.velocity = velocity
        train.position.x = 480 + 1000 if velocity < 0 else -1000
        train.position.y = -13
        trains.add_child(train)
