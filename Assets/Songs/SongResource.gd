extends Resource
class_name SongResource

export(String) var name
export(int) var bpm
export(Array, int) var notes # note indices as in NoteFrequencies

var low: int = NoteFrequencies.NotesEnum.C_5_Recorder_Low
var high: int = NoteFrequencies.NotesEnum.A_6_Recorder_Highest

func _init(m_name = "New Song", m_bpm = 120, m_notes = []):
	print("- New Song Resource Created! (" + m_name + ")")
	name = m_name
	m_bpm = m_bpm
	notes = m_notes.duplicate()
