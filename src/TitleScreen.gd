extends Node2D

signal game_started

func _ready():
    $StartSprite.play()

func show():
    visible = true

func _process(_delta):
    if visible && Input.is_action_just_pressed("ui_select"):
        visible = false
        emit_signal("game_started")
