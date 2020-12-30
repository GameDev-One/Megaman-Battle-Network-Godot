class_name JSONParser
extends Node
"""
# file		json_parser.gd
# author	Devone Reynolds
# par		email: gamedevone1@gmail.com
# date		21 DEC 2020
# brief		Converts a JSON file created from Twinery 2.0 into Passages.
# note		To be used in conjuntion with a Dialogue Node to display 
			conversations on screen.
# note		See 'https://youtu.be/kdy5xN7nBWM' for a tutorial on creating the 
			JSON
"""


# Files need to be placed in the 'res://assets/data/' to be read correctly
var file_name:String = ""

# An array of custom Passage Nodes
var passages: Array = []

# Needed for an intermediate step to convert the JSON into Passages
var _parsed_json_object: Dictionary = {}


"""
# brief		Convert JSON file into Passage Objects.
"""
func create_passages() -> void:
	#Load JSON into Dictionary
	_parsed_json_object = _load_json(file_name)
	
	#Verify Twine JSON and convert to Passages
	if not _parsed_json_object.empty():
		if _verify_twine(_parsed_json_object):
			_to_passages(_parsed_json_object)


"""
# brief			Load JSON into the game and seperate each field into a Dictionary
				for easy lookups.
# param name	
				Name of the JSON file to be converted
# return
				Parsed JSON object as a Dictionary, else an empty Dictionary
"""
func _load_json(name: String) -> Dictionary:
	# New file
	var file: File = File.new()
	
	# Results from parsing JSON file
	var content: JSONParseResult = null
	
	# Read file if name is given
	if not name.empty():
		# Error code
		var err = file.open(name, File.READ)
		
		# Generate warning and return empty Dictionary if failed to read file
		if not err == OK:
			push_warning("Failed to read JSON file <" + name + ">.")
			push_warning("Error Code: "+ String(file.get_error()))
			return {}
	
		# Parse file to JSON
		content = JSON.parse(file.get_as_text())
		
		# Generate warning and return empty Dictionary if failed to parse file
		if not content.error == OK:
			push_warning("Failed to parse JSON file <" + name + ">.")
			push_warning(content.error_string)
			push_warning("Error found @ line number: " + String(content.error_line))
			return {}
	
		# Close file and return results as a Dictionary
		file.close()
		return content.result
	
	# Otherwise return an empty Dictionary
	return {}


"""
# brief			Confirms JSON was created by Twinery.
# param json	
				JSON file that has been previously loaded by _load_json
# return
				True if JSON was created by Twinery, otherwise false.
"""
func _verify_twine(json: Dictionary) -> bool:
	# Look for named key in the json
	var key: String = "creator"
	if json.has(key):
		
		# Return true if creator is Twine 
		if json.get(key) == "Twine":
			return true
			
	# Otherwise generate warning and return false
	push_warning("JSON file not created by Twinery.")
	push_warning("Make sure to follow instructions from: ")
	push_warning("<https://youtu.be/kdy5xN7nBWM> to create file.")
	return false


"""
# brief			Convert parsed json object into Passage Objects.
# param json	
				JSON file that has been previously loaded by _load_json
"""
func _to_passages(json: Dictionary) -> void:
	var psgs: Array = json.get("passages")
	
	#For each passage create an entry into the passages
	for psg in psgs:
		var entry: Passage = Passage.new()
		entry.text = _strip_links_from_text(psg.get("text"))
		entry.pid = psg.get("pid")
		
		#Last passage does not have a link to another passage
		if psg.has("links"):
			for lnk in psg.get("links"):
				var link_entry = PassageLink.new()
				link_entry.text = lnk.name
				link_entry.pid = lnk.pid
				entry.links.append(link_entry)
		
		# Add to group of passages
		passages.append(entry)


"""
# brief			Removes any notation for links to other passages. Links to other
				passages are surrounded by double square brackets '[[]]'.
# param text	
				Text from the passage
# return
				Text without notation for links
"""
func _strip_links_from_text(text: String) -> String:
	# Find the starting point of the links
	var start_index = text.find("[[")
	var clip = text.substr(start_index)
	
	# Return text with links stripped out
	return text.rstrip(clip)
