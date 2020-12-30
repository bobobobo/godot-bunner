extends Node2D



func _ready():
    var white_font = BitmapFont.new()
    var gold_font = BitmapFont.new()

    var all_chars = "01234567890"
    var textureIdx = 0
    for c in all_chars:
        var white_texture = load("res://assets/sprites/digit0" + c + ".png")
        white_font.add_texture(white_texture)
        white_font.add_char(ord(c), textureIdx, Rect2(3, 0, 27, white_texture.get_height()))

        var gold_texture = load("res://assets/sprites/digit1" + c + ".png")
        gold_font.add_texture(gold_texture)
        gold_font.add_char(ord(c), textureIdx, Rect2(3, 0, 27, gold_texture.get_height()))

        textureIdx += 1
    $CurrentScore.add_font_override("font", white_font)
    $HighScore.add_font_override("font", gold_font)
    # $ScoreLabel.add_font_override("font", font)


func set_current_score(score):
    $CurrentScore.set_text(str(score))

func set_high_score(score):
    $HighScore.set_text(str(score))
    
