extends Reference

const Constants = preload('res://addons/sph_fluid/scripts/constants.gd')

static func particle_position_to_screen(particle_position):
    return particle_position * Constants.SCALE

static func screen_position_to_particle(screen_position):
    return screen_position / Constants.SCALE
