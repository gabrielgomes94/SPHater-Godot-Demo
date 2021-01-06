extends Node2D

const DUMPING_VELOCITY = -0.00001
const COLLISION_OFFSET = 0.009
const TILEMAP_OFFSET = 100

func calculate(draw_point, particle, space_state):
	var intersections = _get_intersections(draw_point.position, space_state)

	if intersections.empty():
		return

	var tilemap = intersections[0]['collider']
	if not _has_tilemap_collider(tilemap):
		return

	var tilemap_position = tilemap.map_to_world(intersections[0]['metadata'])

	if _collided_right(particle, draw_point, tilemap_position):
		draw_point.position.x = tilemap_position.x + TILEMAP_OFFSET
		particle.position.x -= COLLISION_OFFSET
		particle.velocity.x *= DUMPING_VELOCITY
	elif _collided_left(particle, draw_point, tilemap_position):
		draw_point.position.x = tilemap_position.x
		particle.position.x += COLLISION_OFFSET
		particle.velocity.x *= DUMPING_VELOCITY

	if _collided_bottom(particle, draw_point, tilemap_position):
		draw_point.position.y = tilemap_position.y - TILEMAP_OFFSET
		particle.position.y -= COLLISION_OFFSET
		particle.velocity.y *= DUMPING_VELOCITY
	elif _collided_top(particle, draw_point, tilemap_position):
		draw_point.position.y = tilemap_position.y +  TILEMAP_OFFSET
		particle.position.y += COLLISION_OFFSET
		particle.velocity.y *= DUMPING_VELOCITY


func _collided_right(particle, draw_point, tilemap_position):
	return particle.velocity.x > 0 and draw_point.position.x > tilemap_position.x


func _collided_left(particle, draw_point, tilemap_position):
	return particle.velocity.x < 0 and particle.velocity.x < tilemap_position.x


func _collided_bottom(particle, draw_point, tilemap_position):
	return particle.velocity.y > 0 and draw_point.position.y > tilemap_position.y


func _collided_top(particle, draw_point, tilemap_position):
	return particle.velocity.y < 0 and draw_point.position.y < tilemap_position.y


func _get_intersections(position, space_state):
	return space_state.intersect_point(position, 32, [], 0x7FFFFFFF, true, true)


func _has_tilemap_collider(tilemap):
	return tilemap and tilemap.get_class() == 'TileMap'
