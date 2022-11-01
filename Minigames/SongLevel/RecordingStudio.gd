extends Control

onready var song_name_input = $"%SongNameInput"
onready var bpm_input = $"%BpmInput"
onready var start_timer = $"%StartTimer"
onready var note_timer = $"%NoteTimer"
onready var fletnicka = $MicrophoneInput
onready var note_label = $"%NoteLabel"
onready var subtitle = $"%Subtitle"
onready var timedLabel := $"%TimedLabel"
onready var timeLeftLabel := $"%TimeLeftLabel"


var is_recording = false

# Note indices that are scanned while recording
var played_notes = []
var song_resource = null

func _process(_delta):
	note_label.text = NoteFrequencies.names[fletnicka.current_note]
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
	
	song_resource = SongResource.new()
	song_resource.name = "Recorded " + str(len(played_notes))
	song_resource.bpm = bpm_input.value
	song_resource.notes = played_notes

func _on_SaveSong_pressed():
	if song_name_input.text != "":
		var result = ResourceSaver.save("res://Assets/Songs/" + song_name_input.text.replace(" ", "_") + ".tres", song_resource)
		if result != OK:
			timedLabel.set_timed_text("Saving failed (" + str(result) + ")")
		else:
			timedLabel.set_timed_text("Song saved successfully!")
		song_name_input.text = "New Song Title"
	else:
		timedLabel.set_timed_text("Fill in song name")


func _on_NoteTimer_timeout():
	played_notes.append(round(fletnicka.current_note))


func _on_StartTimer_timeout():
	is_recording = true
	note_timer.wait_time = 60 / bpm_input.value
	note_timer.start()
