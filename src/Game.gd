extends Node2D

onready var level = $Level
onready var game_over = $GameOver
onready var title_screen = $TitleScreen

func _ready():
    SoundEffectPlayer.add_sound("jump", ["res://assets/sound/jump0.wav"])
    SoundEffectPlayer.add_sound("splat", ["res://assets/sound/splat0.wav"])
    SoundEffectPlayer.add_sound("splash", ["res://assets/sound/splash0.wav"])
    SoundEffectPlayer.add_sound("eagle", ["res://assets/sound/eagle0.wav"])
    SoundEffectPlayer.add_sound("log", ["res://assets/sound/log0.wav"])
    SoundEffectPlayer.add_sound("dirt", ["res://assets/sound/dirt0.wav"])
    SoundEffectPlayer.add_sound("grass", ["res://assets/sound/grass0.wav"])
    SoundEffectPlayer.add_sound("road", ["res://assets/sound/road0.wav"])
    SoundEffectPlayer.add_sound("sidewalk", ["res://assets/sound/sidewalk0.wav"])
    SoundEffectPlayer.add_sound("bell", ["res://assets/sound/bell0.wav"])
    SoundEffectPlayer.add_sound("train", ["res://assets/sound/train0.wav","res://assets/sound/train1.wav"])
    SoundEffectPlayer.add_sound("zoom", ["res://assets/sound/zoom0.wav","res://assets/sound/zoom1.wav","res://assets/sound/zoom2.wav","res://assets/sound/zoom3.wav","res://assets/sound/zoom4.wav","res://assets/sound/zoom5.wav"])
    SoundEffectPlayer.add_sound("honk", ["res://assets/sound/honk0.wav","res://assets/sound/honk1.wav","res://assets/sound/honk2.wav","res://assets/sound/honk3.wav","res://assets/sound/honk4.wav"])
    SoundEffectPlayer.add_sound("traffic", ["res://assets/sound/traffic0.ogg","res://assets/sound/traffic1.ogg", "res://assets/sound/traffic2.ogg"], true)
    SoundEffectPlayer.add_sound("river", ["res://assets/sound/river0.ogg","res://assets/sound/river1.ogg"], true)

    SoundEffectPlayer.enabled = false
    $MusicPlayer.play()

func _on_Level_game_over():
    SoundEffectPlayer.enabled = false
    $MusicPlayer.volume_db = 0
    game_over.show()

func _on_GameOver_game_restart():
    SoundEffectPlayer.enabled = false
    $MusicPlayer.volume_db = 0
    level.start(false)
    title_screen.show()

func _on_TitleScreen_game_started():
    SoundEffectPlayer.enabled = true
    $MusicPlayer.volume_db = -20
    level.start(true)
