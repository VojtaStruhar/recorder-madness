extends Control

onready var song_name_input = $"%SongNameInput"
onready var bpm_input = $"%BpmInput"
onready var start_timer = $"%StartTimer"
onready var note_timer = $"%NoteTimer"
onready var fletnicka = $MicrophoneInput
onready var note_label = $"%NoteLabel"
onready var note_index_label = $"%NoteIndexLabel"
onready var subtitle = $"%Subtitle"
onready var timedLabel := $"%TimedLabel"
onready var timeLeftLabel := $"%TimeLeftLabel"
onready var metronomeLabel := $"%MetronomeLabel"

var is_recording = false

# Note indices that are scanned while recording
var played_notes = []
var song_resource = null

func _process(_delta):
	note_label.text = NoteFrequencies.names[fletnicka.current_note]
	note_index_label.text = "-" if fletnicka.is_quiet else str(fletnicka.current_note)
	if fletnicka.error_message != "":
		subtitle.text = fletnicka.error_message
	else:
		subtitle.text = "Start playing, record the notes to an array and save it as a resource!"
		
	timeLeftLabel.text = str(int(start_timer.time_left * 100) / 100.0)


func _on_StartRecording_pressed():
	if is_recording: return
	played_notes = []
	start_timer.start()


func _on_StopRecording_pressed():
	if !is_recording: return
	is_recording = false
	note_timer.stop()
	
	var low = 100
	var high = 0
	for note in played_notes:
		low = min(low, note)
		high = max(high, note)
	
	song_resource = SongResource.new()
	song_resource.name = "Recorded " + str(len(played_notes))
	song_resource.bpm = bpm_input.value
	song_resource.notes = played_notes
	song_resource.low = max(low - 2, NoteFrequencies.NotesEnum.C_5_Recorder_Low)
	song_resource.high = min(high + 2, NoteFrequencies.NotesEnum.A_6_Recorder_Highest)

func _on_SaveSong_pressed():
	if song_name_input.text != "":
		song_resource.name = song_name_input.text
		var result = ResourceSaver.save("res://Assets/Songs/" + song_name_input.text.replace(" ", "_") + ".tres", song_resource)
		if result != OK:
			timedLabel.set_timed_text("Saving failed (" + str(result) + ")")
		else:
			timedLabel.set_timed_text("Song saved successfully!")
		song_name_input.text = "New Song Title"
	else:
		timedLabel.set_timed_text("Fill in song name")


func _on_NoteTimer_timeout():
	if fletnicka.is_quiet:
		played_notes.append(-1)
	else:
		played_notes.append(round(fletnicka.current_note))
	metronomeLabel.set_timed_text("( X )")


func _on_StartTimer_timeout():
	is_recording = true
	note_timer.wait_time = 60 / bpm_input.value
	metronomeLabel.wait_time = (60 / bpm_input.value) / 3
	note_timer.start()
