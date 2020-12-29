extends Node2D


func _draw():
    for i in range(12):
        draw_rect(Rect2(i*40, 0, i*40+40, 40), "#ffffff", false)
