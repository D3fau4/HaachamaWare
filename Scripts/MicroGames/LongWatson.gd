extends MicroGame

const quality = 20
var points = []
var moving_points = quality
var pos = 1

func _ready():
	for i in range(quality):
		points.append(1.0)

func _process(delta):
	$Scan.position.x-=delta*240*$"..".difficulty
	$BG2.region_rect.size.x=clamp($Scan.position.x/4,0,240)
	$Ame.position.x+=(Input.get_action_strength("right")-Input.get_action_strength("left"))*delta*480*$"..".difficulty
	$Ame.region_rect.size.x=clamp(($Scan.position.x-$Ame.position.x)/4,0,108)
	moving_points=clamp(($Scan.position.x-$Stretch.rect_position.x)/$Stretch.rect_size.x,0,1)*20
	pos=($Scan.position-$Ame.position).x/432
	if $Scan.position.x<$StartScan.position.x and $Scan.position.x>$EndScan.position.x:
		if pos>1:
			lose()
		if pos<0:
			lose()
	for i in range(len(points)):
		if i<moving_points:
			$Stretch.material.set_shader_param("p"+str(i+1),pos)