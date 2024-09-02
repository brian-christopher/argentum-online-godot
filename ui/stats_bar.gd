extends ProgressBar
class_name StatsBar

func set_bar_value(p_min_value:int, p_max_value:int) -> void:
	max_value = p_max_value
	value = p_min_value 
	%Value.text = "%d/%d" % [p_min_value, p_max_value]
