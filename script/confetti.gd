extends CPUParticles2D

func _ready():
	# Set up particles properties
	amount = 300
	lifetime = 3
	one_shot = false
	preprocess = 0
	emission_shape = CPUParticles2D.EMISSION_SHAPE_BOX
	emission_box_extents = Vector3(500, 0, 0)

	# Create and configure the material
	var particles_material = ParticlesMaterial.new()
	particles_material.gravity = Vector3(0, 200, 0)
	particles_material.initial_velocity = 100
	particles_material.spread = 180
	particles_material.scale = 0.15
	particles_material.scale_random = 0.5

	# Set up color gradient
	var gradient = Gradient.new()
	gradient.add_point(0.0, Color(1, 0, 0))  # Red
	gradient.add_point(0.2, Color(0, 1, 0))  # Green
	gradient.add_point(0.4, Color(0, 0, 1))  # Blue
	gradient.add_point(0.6, Color(1, 1, 0))  # Yellow
	gradient.add_point(0.8, Color(1, 0, 1))  # Magenta
	gradient.add_point(1.0, Color(0, 1, 1))  # Cyan

	var gradient_texture = GradientTexture2D.new()
	gradient_texture.gradient = gradient
	particles_material.color_ramp = gradient_texture

	# Assign the material to the particles
	process_material = particles_material
