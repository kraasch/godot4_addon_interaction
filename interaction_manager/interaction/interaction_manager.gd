extends Node2D

@onready var player = get_tree().get_first_node_in_group('player_group')
@onready var label : Label = $Label

const base_text = '[E] to '
var active_areas = []
var can_interact = true

func _ready() -> void:
	label = Label.new() # TODO: instantiating this label makes problems.
	print(label)

func register_area(area: InteractionArea):
	active_areas.push_back(area)

func unregister_area(area:InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

@warning_ignore("unused_parameter")
func _process(delta):
	if active_areas.size() > 0 and can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()

func _sort_by_distance_to_player(a_area, b_area):
	var a_dist = player.global_position.distance(a_area)
	var b_dist = player.global_position.distance(b_area)
	return a_dist < b_dist

func _input(event):
	if event.is_action_pressed('pick') and can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			await active_areas[0].interact.call()
			can_interact = true
