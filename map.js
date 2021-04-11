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
  let lessonPosition = 1;
  return sections.map(function (section, i) {

    if (section.reset_lesson_position) {
      lessonPosition = 1;
    }

    const lessons = section.lessons.map(function (lesson) {
      lesson = {...lesson, position: lessonPosition};
      lessonPosition++;
      return lesson;
    });

    return {...section, lessons, position: i + 1};
  }, []);
}

console.log(JSON.stringify(traverse(sections), null, 4));
