class_name Passage
extends Node
"""
# file		passage.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		22 DEC 2020
# brief		Container for text to be displayed as a list
"""


# Text to be displayed in the Dialogue
var text: String = ""

# Id of the passage to allow non-sequential linking to other passages
var pid: int = -1

# Each PassageLink wil be stored here to allow for branching
var links: Array = []
