extends Node2D

var state = 'empty'
var is_player_in_area = false

func _ready():
	if state == 'empty':
		$GrowTimer.start()

func _process(delta):
	if state == 'empty':
		$AnimatedSprite2D.play('empty')
	if state == 'ripe':
		$AnimatedSprite2D.play('ripe')
		if is_player_in_area:
			if Input.is_action_just_pressed('pick'):
				state = 'empty'
				$GrowTimer.start()
		
