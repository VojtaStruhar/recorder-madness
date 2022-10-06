extends Node

enum NoteBufferProcessingMode {
	AVERAGE, MEDIAN
}
var processing_mode = NoteBufferProcessingMode.MEDIAN

# This is the main observed property to the outside world. Stores current note
var current_note: float = 0

const HIGHEST_NOTE_INDEX = 45 # 45 is A2, it's the highest note I'm comfortable playing, really.
const LOWEST_NOTE_INDEX = 24 # 24 is the low C on my recorder

const NOTES_BUFFER_SIZE = 4
var notes_buffer = []

var spectrum_analyzer: AudioEffectSpectrumAnalyzerInstance

func _ready() -> void:
	var record_bus_index = AudioServer.get_bus_index('Fletnicka')
	# We get 0th effect, since it's the only one on the bus
	spectrum_analyzer = AudioServer.get_bus_effect_instance(record_bus_index, 0)


func _process(_delta: float) -> void:
	analyze_recorder_notes()

func analyze_recorder_notes() -> void:
	var highest_magnitude: float = -1
	var highest_magnitude_note_index: int = -1
	
	for i in range(1, len(NoteFrequencies.notes) - 1):
		var mag = spectrum_analyzer.get_magnitude_for_frequency_range(
			NoteFrequencies.notes[i - 1],
			NoteFrequencies.notes[i + 1],
			AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_AVERAGE
		).length()
		
		if mag > highest_magnitude:
			highest_magnitude = mag
			highest_magnitude_note_index = i
	
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
	
