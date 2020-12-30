extends Node
"""
# file		dialogue.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		26 DEC 2020
# brief		Allows the player to have converstaions with Objects in the world.
# note		To be used in conjuntion with a JSONParser Node to display 
			conversations on screen.
# note		See 'https://youtu.be/kdy5xN7nBWM' for a tutorial on creating the 
			JSON
"""


signal last_passage_reached

# File path for any dialogue the player would have with this NPC
var file_name: String = ""

# Total number of dialogue passages loaded from the JSON
var num_passages: int = 0

# Where or not the current passage has multiple options to choose from
var can_branch: bool = false

# Index of the current passage
var _passage_index: int = -1

# Reference to the JSONParser Node
onready var _parser: JSONParser = $JSONParser

# Reference to the UI Node
onready var _ui: Control = $UI

# Reference to the UIText Node
onready var _ui_text: Label = $UI/HSort/DialoguePnl/Label

# Reference to the OptionPnl Node
onready var _opt_pnl: Panel = $UI/HSort/OptionPnl

# Reference to the first Option Button
onready var _opt_1: Button = $UI/HSort/OptionPnl/VSort/Button

# Reference to the second Option Button
onready var _opt_2: Button = $UI/HSort/OptionPnl/VSort/Button2

# Reference to the third Option Button
onready var _opt_3: Button = $UI/HSort/OptionPnl/VSort/Button3

# Reference to the fourth Option Button
onready var _opt_4: Button = $UI/HSort/OptionPnl/VSort/Button4

# Refernce to the passages loaded from the JSONParser
onready var _passages: Array = $JSONParser.passages


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	# Create new passages from the file
	yield(owner,"ready")
	_parser.file_name = file_name
	_parser.create_passages()
	
	# Determine total number of passages
	num_passages = _passages.size()
	
	# Hide all UI elements
	_opt_pnl.hide()
	hide()


"""
# brief		Hide all dialogue UI elements on the screen
"""
func hide() -> void:
	_ui.hide()


"""
# brief		Show all dialogue UI elements on the screen
"""
func show() -> void:
	_ui.show()


"""
# brief		Move to the next passage in the dialogue
"""
func advance() -> void:
	_passage_index += 1
	change_passage(_passage_index)


"""
# brief			Display requested passage from the container of passages
# param index
				Id of the passage to change to
"""
func change_passage(index: int) -> void:
	# Check if not the first or beyond the last passage
	if num_passages > 0 and index < num_passages:
		# Display text from the indexed passage
		_passage_index = index
		_ui_text.text = _passages[index].text
		
		# Reset if the passage has options before checking again
		can_branch = false
		
		# Display options for passage if passage has multiple links
		match _passages[index].links.size():
			# Two options
			2:
				_opt_1.text = _passages[index].links[0].text
				_opt_2.text = _passages[index].links[1].text
				_opt_3.text = ""
				_opt_4.text = ""
				_opt_pnl.show()
				_opt_1.show()
				_opt_2.show()
				_opt_3.hide()
				_opt_4.hide()
				_opt_1.grab_focus()
				can_branch = true
				
			# Three options
			3:
				_opt_1.text = _passages[index].links[0].text
				_opt_2.text = _passages[index].links[1].text
				_opt_3.text = _passages[index].links[2].text
				_opt_4.text = ""
				_opt_pnl.show()
				_opt_1.show()
				_opt_2.show()
				_opt_3.show()
				_opt_4.hide()
				_opt_1.grab_focus()
				can_branch = true
				
			# Four options
			4:
				_opt_1.text = _passages[index].links[0].text
				_opt_2.text = _passages[index].links[1].text
				_opt_3.text = _passages[index].links[2].text
				_opt_4.text = _passages[index].links[3].text
				_opt_pnl.show()
				_opt_1.show()
				_opt_2.show()
				_opt_3.show()
				_opt_4.show()
				_opt_1.grab_focus()
				can_branch = true
			
			# Invalid number of options show no options at all
			_:
				_opt_1.text = ""
				_opt_2.text = ""
				_opt_3.text = ""
				_opt_4.text = ""
				_opt_pnl.hide()
				_opt_1.hide()
				_opt_2.hide()
				_opt_3.hide()
				_opt_4.hide()
				can_branch = false
		
	# Otherwise reached last passage
	else:
		emit_signal("last_passage_reached")


"""
# brief		Switch to selected passage when button is pressed
# note		Each button correlates to a passage link to the next passage
"""
func _on_Button_pressed() -> void:
	# Find the current passage's first link
	var current_passage: Passage = _passages[_passage_index]
	var next_passage_pid: int = current_passage.links[0].pid
	
	# Using the link, search for the selected passage
	var index: int = 0
	for psg in _passages:
		# Change to selected passage if link id found
		if psg.pid == next_passage_pid:
			change_passage(index)
			pass
			
		# Otherwise move to the next passage in the list
		index += 1


"""
# brief		Switch to selected passage when button is pressed
# note		Each button correlates to a passage link to the next passage
"""
func _on_Button2_pressed() -> void:
	# Find the current passage's second link
	var current_passage: Passage = _passages[_passage_index]
	var next_passage_pid: int = current_passage.links[1].pid
	
	# Using the link, search for the selected passage
	var index: int = 0
	for psg in _passages:
		# Change to selected passage if link id found
		if psg.pid == next_passage_pid:
			change_passage(index)
			pass
			
		# Otherwise move to the next passage in the list
		index += 1


"""
# brief		Switch to selected passage when button is pressed
# note		Each button correlates to a passage link to the next passage
"""
func _on_Button3_pressed() -> void:
	# Find the current passage's third link
	var current_passage: Passage = _passages[_passage_index]
	var next_passage_pid: int = current_passage.links[2].pid
	
	# Using the link, search for the selected passage
	var index: int = 0
	for psg in _passages:
		# Change to selected passage if link id found
		if psg.pid == next_passage_pid:
			change_passage(index)
			pass
			
		# Otherwise move to the next passage in the list
		index += 1


"""
# brief		Switch to selected passage when button is pressed
# note		Each button correlates to a passage link to the next passage
"""
func _on_Button4_pressed() -> void:
	# Find the current passage's fourth link
	var current_passage: Passage = _passages[_passage_index]
	var next_passage_pid: int = current_passage.links[3].pid
	
	# Using the link, search for the selected passage
	var index: int = 0
	for psg in _passages:
		# Change to selected passage if link id found
		if psg.pid == next_passage_pid:
			change_passage(index)
			pass
			
		# Otherwise move to the next passage in the list
		index += 1
