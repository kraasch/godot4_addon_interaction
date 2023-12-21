extends Node2D

var state = 'empty'

func _ready():
	if state == 'empty':
		$GrowTimer.start()
	$InteractionArea.interact = Callable(self, '_on_interact')
	
func _on_interact():
	state = 'empty'

func _process(delta):
	if state == 'empty':
		$AnimatedSprite2D.play('empty')
	if state == 'ripe':
		$AnimatedSprite2D.play('ripe')

func _on_grow_timer_timeout():
	if state == 'empty':
		state = 'ripe'
