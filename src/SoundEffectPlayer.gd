
extends Node

var sounds =  {}
var enabled = true
var playing = {}

func _ready():
    pause_mode = PAUSE_MODE_PROCESS

func add_sound(name, files, loop = false):
    var streams = []
    for file_name in files:
        var loaded_stream = load(file_name)	
        if loaded_stream is AudioStreamOGGVorbis:
            loaded_stream.set_loop(loop)
        streams.append(loaded_stream)
    sounds[name] = streams
    
func play(name, volume = 1):
    if enabled:
        call_deferred("_play", name, volume)

func play_singleton(name, volume = 1):
    if enabled:
        call_deferred("_play_singleton", name, volume)

func stop_singleton(name):
    call_deferred("_stop_singleton", name)

func _play_singleton(name, volume = 1):
    if not name in sounds:
        return

    if name in playing:
        playing[name].volume_db = volume
    else:
        var asp = _create_asp(name, volume)
        asp.play()
        playing[name] = asp
        
func _stop_singleton(name):
    if name in playing:
        playing[name].stop()
        playing[name].queue_free()
        playing.erase(name)




func _play(name, volume):
    if not name in sounds:
        return
    var asp = _create_asp(name, volume)
    asp.play()
    yield(asp, "finished")
    asp.queue_free()


func _create_asp(name, volume):
    var asp = AudioStreamPlayer.new()
    asp.pause_mode = PAUSE_MODE_PROCESS
    asp.volume_db = volume
    get_parent().add_child(asp)
    asp.stream = sounds[name][randi() % sounds[name].size()]
    return asp
