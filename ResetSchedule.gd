extends Timer

signal midnight

var system_time
var hour
var minute
var second

func _ready():
	print(system_time)
	print(hour)
	print(minute)
	print(second)
	

func _process(delta):
	system_time = OS.get_time()
	hour = system_time.hour
	minute = system_time.minute
	second = system_time.second
	if hour == 24 and minute == 0 and (second >= 0 or second <= 4):
		emit_signal("midnight")
