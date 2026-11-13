extends CharacterBody2D

@export var speed: float = 300.0
@export var jump_velocity: float = -400.0

func jump():
	velocity.y = jump_velocity
	
func jump_side(x):
	velocity.y = jump_velocity
	velocity.x = x

# Načtení výchozí gravitace z nastavení Godotu
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity.y += gravity * delta
	# Pokud se postava hýbe doprava NEBO doleva
	if velocity.x > 1 or velocity.x < -1:
		$AnimatedSprite2D.animation = "runing"
	else:
		$AnimatedSprite2D.animation = "Idle"
	# 2. Skok (při stisknutí Mezerníku / up a zároveň stojíte na zemi)
	if Input.is_action_just_pressed("up")and is_on_floor():
		velocity.y = jump_velocity * GameManager.potion_velocity
	
	# 3. Pohyb vlevo a vpravo (A/D nebo šipky)
	var direction := Input.get_axis("left", "right")
	
	if direction != 0:
		velocity.x = direction * speed
		
		# Otočení obrázku podle směru chůze
		if direction < 0:
			$AnimatedSprite2D.flip_h = true   # Otočí vlevo
		else:
			$AnimatedSprite2D.flip_h = false  # Otočí vpravo
	else:
		# Plynulé zastavení na zemi
		velocity.x = move_toward(velocity.x, 0, speed)


	# 4. Spuštění fyziky a pohybu
	move_and_slide()
	# 5. SPRÁVNÉ PŘEPÍNÁNÍ ANIMACÍ (včetně pádu)
	if not is_on_floor():
		# Postava je ve vzduchu
		if velocity.y < 0:
			# Letí nahoru -> hraje skok
			if $AnimatedSprite2D.animation != "jumping":
				$AnimatedSprite2D.play("jumping")
		else:
			# Letí dolů -> hraje pád
			if $AnimatedSprite2D.animation != "faling":
				$AnimatedSprite2D.play("faling")
	else:
		# Postava je na zemi
		if abs(velocity.x) > 1.0:
			if $AnimatedSprite2D.animation != "runing":
				$AnimatedSprite2D.play("runing")
		else:
			if $AnimatedSprite2D.animation != "Idle":
				$AnimatedSprite2D.play("Idle")
