class_name Enemy
extends RigidBody
"""
# file		enemy.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		27 DEC 2020
# brief		Base class for all Objects consider to be an enemy
"""

# Current Health of the enemy
export(int, 0, 9999) var health = 0

# Max health the enemy can potientially have
export(int, 0, 9999) var max_health = 0
