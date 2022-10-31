extends Resource

export(String) var name
export(Array, int) var notes # note indices as in NoteFrequencies

func _init(m_name = "New Song", m_notes = []):
	name = m_name
	notes = m_notes
