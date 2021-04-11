const sections = [
  {
    "title": "Getting started",
    "reset_lesson_position": false,
    "lessons": [
      {"name": "Welcome"},
      {"name": "Installation"}
    ]
  },

  {
    "title": "Basic operator",
    "reset_lesson_position": false,
    "lessons": [
      {"name": "Addition / Subtraction"},
      {"name": "Multiplication / Division"}
    ]
  },

  {
    "title": "Advanced topics",
    "reset_lesson_position": true,
    "lessons": [
      {"name": "Mutability"},
      {"name": "Immutability"}
    ]
  }
];

function traverse(sections) {
  let result = [];
  let lessonPosition = 1;

  for (let i = 0; i < sections.length; i++) {
    let section = sections[i];

    if (section.reset_lesson_position) {
      lessonPosition = 1;
    }

    const lessons = [];
    for (let j = 0; j < section.lessons.length; j++) {
      let lesson = section.lessons[j];
      lesson = Object.assign({position: lessonPosition}, lesson);
      lessons.push(lesson);
      lessonPosition++;
    }

    section = Object.assign({}, section, {position: i + 1, lessons});
    result.push(section);
  }

  return result;
}

console.log(JSON.stringify(traverse(sections), null, 4));
