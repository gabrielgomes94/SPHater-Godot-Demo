# Use this script when you want to test the SPH lib in a simple box enviroment.
extends Node2D

const Constants = preload('res://addons/sph_fluid/scripts/constants.gd')

func calculate(particle):
    if particle.position.x < 0:
        particle.position.x = 0
        particle.velocity.x *= -0.1
    elif particle.position.x > Constants.WIDTH:
        particle.position.x = Constants.WIDTH
        particle.velocity.x *= -0.1

    if particle.position.y < 0:
        particle.position.y = 0
        particle.velocity.y *= -0.1
    elif particle.position.y > Constants.HEIGHT:
        particle.position.y = Constants.HEIGHT
        particle.velocity.y *= -0.1
