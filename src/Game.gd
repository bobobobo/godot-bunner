extends Node2D

onready var level = $Level
onready var game_over = $GameOver
onready var title_screen = $TitleScreen

func _on_Level_game_over():
    game_over.show()

func _on_GameOver_game_restart():
    level.start(false)
    title_screen.show()

func _on_TitleScreen_game_started():
    level.start(true)