sections = [
    {
        "title": "Getting started",
        "reset_lesson_position": False,
        "lessons": [
            {"name": "Welcome"},
            {"name": "Installation"}
        ]
    },

    {
        "title": "Basic operator",
        "reset_lesson_position": False,
        "lessons": [
            {"name": "Addition / Subtraction"},
            {"name": "Multiplication / Division"}
        ]
    },

    {
        "title": "Advanced topics",
        "reset_lesson_position": True,
        "lessons": [
            {"name": "Mutability"},
            {"name": "Immutability"}
        ]
    }
]

section_position = 1
lesson_position = 1
for section in sections:
    section["position"] = section_position
    section_position += 1

    if section["reset_lesson_position"]:
        lesson_position = 1

    for lesson in section["lessons"]:
        lesson["position"] = lesson_position
        lesson_position += 1

print(sections)
