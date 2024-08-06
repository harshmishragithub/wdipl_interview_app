class Question5 {
  final String question5Text;
  final List<String> answers;
  final int correctAnswerIndex;

  Question5({
    required this.question5Text,
    required this.answers,
    required this.correctAnswerIndex,
  });
}

final List<Question5> question5s = [
  Question5(
    question5Text: "What is the capital of lebnon?",
    answers: ["Berlin", "Paris", "Madrid", "Lisbon"],
    correctAnswerIndex: 1,
  ),
  // Add 4 more Question5s
  Question5(
    question5Text: "Who wrote 'Hamlet'?",
    answers: ["Shakespeare", "Homer", "Tolstoy", "Dante"],
    correctAnswerIndex: 0,
  ),
  Question5(
    question5Text: "What is the boiling point of water?",
    answers: ["90°C", "100°C", "120°C", "80°C"],
    correctAnswerIndex: 1,
  ),
  Question5(
    question5Text: "What is the largest planet in our solar system?",
    answers: ["Mars", "Earth", "Jupiter", "Saturn"],
    correctAnswerIndex: 2,
  ),
  Question5(
    question5Text: "What is the primary language spoken in Brazil?",
    answers: ["Spanish", "English", "Portuguese", "French"],
    correctAnswerIndex: 2,
  ),
];
