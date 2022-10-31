extends Node

class_name MicrophoneInput

enum NoteBufferProcessingMode {
	AVERAGE, MEDIAN
}
export (NoteBufferProcessingMode) var processing_mode = NoteBufferProcessingMode.MEDIAN

export(NoteFrequencies.NotesEnum) var HIGHEST_NOTE_INDEX = 40 # 45 is A2, it's the highest note I'm comfortable playing, really.
export(NoteFrequencies.NotesEnum) var LOWEST_NOTE_INDEX = 24 # 24 is the low C on my recorder

# This is the main observed property to the outside world. Stores current note
var current_note: float = LOWEST_NOTE_INDEX
# Stores current note in the context of Recorder's range. From 0 to 1
var current_note_normalized: float = 0
# If the scanned magnitude is very low, we mark the state as quiet
var is_quiet: bool = false

export var NOTES_BUFFER_SIZE = 7
export var QUIET_TOLERANCE = 7 # How many frames can we be quiet until it gets "announced"
var _quiet_score = 0 # How many frames are we currently quiet

var notes_buffer = []

var spectrum_analyzer: AudioEffectSpectrumAnalyzerInstance

var error_message: String = ""

func _ready() -> void:
	var record_bus_index = AudioServer.get_bus_index('Fletnicka')
	# We get 0th effect, since it's the only one on the bus
	spectrum_analyzer = AudioServer.get_bus_effect_instance(record_bus_index, 0)

	assert(HIGHEST_NOTE_INDEX >= LOWEST_NOTE_INDEX)


func _process(_delta: float) -> void:
	analyze_recorder_notes()


func analyze_recorder_notes() -> void:
	var highest_magnitude: float = -1
	var highest_magnitude_note_index: int = -1
	
	for i in range(1, len(NoteFrequencies.notes) - 1):
		var target = NoteFrequencies.notes[i]
		var lower = NoteFrequencies.notes[i - 1]
		var higher = NoteFrequencies.notes[i + 1]
		
		var mag = spectrum_analyzer.get_magnitude_for_frequency_range(
			target - (target - lower) / 2.0,
			target + (higher - target) / 2.0,
			AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_AVERAGE
		).length()
		
		if mag > highest_magnitude:
			highest_magnitude = mag
			highest_magnitude_note_index = i
	
	if highest_magnitude == 0:
		error_message = "No input! Try a different microphone please."
	else: error_message = ""
	
	# Examine signal for quietness
	if highest_magnitude < 0.001: 
		_quiet_score += 1
	else: _quiet_score = 0
	
	is_quiet = _quiet_score > QUIET_TOLERANCE
	
	# include only notes that aren't too low or too high 
	# - usually surrounding noise or silence
	if LOWEST_NOTE_INDEX <= highest_magnitude_note_index and highest_magnitude_note_index <= HIGHEST_NOTE_INDEX:
		notes_buffer.append(highest_magnitude_note_index)
	
	# get rid of excess stored notes
	while notes_buffer.size() > NOTES_BUFFER_SIZE:
		notes_buffer.pop_front()
	
	if processing_mode == NoteBufferProcessingMode.AVERAGE:
		current_note = array_average(notes_buffer)
	elif processing_mode == NoteBufferProcessingMode.MEDIAN:
		current_note = array_median(notes_buffer)
	
	current_note_normalized = clamp((current_note - LOWEST_NOTE_INDEX) / float(HIGHEST_NOTE_INDEX - LOWEST_NOTE_INDEX), 0, 1)


func array_average(arr: Array) -> float:
	var avg = 0.0
	if arr.empty():
		return avg
	
	for i in range(arr.size()):
		avg += arr[i]
	avg /= arr.size()
	return avg
	
func array_median(arr: Array) -> float:
	var median: float = 0.0
	if arr.empty():
		return median
		
	var s_arr = arr.duplicate()
	s_arr.sort()
	return s_arr[s_arr.size() / 2]
	
