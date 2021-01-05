extends Node2D

const DUMPING_VELOCITY = -0.0001

func calculate(draw_point, particle, space_state):
	var intersections = space_state.intersect_point(
			#particle_draw_position,
			draw_point.position,
			32,
			[],
			0x7FFFFFFF,
			true,
			true)

	if intersections.empty():
		return

	var tilemap = intersections[0]['collider']

	if tilemap and tilemap.get_class() == 'TileMap':
		var coord = intersections[0]['metadata']
		var tilemap_position = tilemap.map_to_world(coord)

		# se a parede está a direita
		if particle.velocity.x > 0 and draw_point.position.x > tilemap_position.x:
			draw_point.position.x = tilemap_position.x
			particle.position.x -= 0.0009
			particle.velocity.x *= DUMPING_VELOCITY
		# se a parede está a esquerda
		elif particle.velocity.x < 0 and particle.velocity.x < tilemap_position.x:
			draw_point.position.x = tilemap_position.x
			particle.position.x += 0.0009
			particle.velocity.x *= DUMPING_VELOCITY

		# se a parede está abaixo
		if particle.velocity.y > 0 and draw_point.position.y > tilemap_position.y:
			draw_point.position.y = tilemap_position.y - 10
			particle.position.y -= 0.009
			particle.velocity.y *= DUMPING_VELOCITY
		# se a parede está acima
		elif particle.velocity.y < 0 and draw_point.position.y < tilemap_position.y:
			draw_point.position.y = tilemap_position.y + 10
			particle.position.y += 0.009
			particle.velocity.y *= DUMPING_VELOCITY

