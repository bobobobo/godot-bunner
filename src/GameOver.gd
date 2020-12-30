extends Sprite

signal game_restart

func show():
    visible = true
    get_tree().paused = true

func _process(_delta):
    if visible && Input.is_action_just_pressed("ui_select"):
        visible = false
        get_tree().paused = false
        emit_signal("game_restart")
