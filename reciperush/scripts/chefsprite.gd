extends CharacterBody2D

const SPEED = 150

func _physics_process(delta):
	var input = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	velocity = input * SPEED
	move_and_slide()

	var sprite = $AnimatedSprite2D
	if input == Vector2.ZERO:
		sprite.stop()
	else:
		sprite.play("walk")
