class Question3 {
  final String question3Text;
  final List<String> answers;
  final int correctAnswerIndex;

  Question3({
    required this.question3Text,
    required this.answers,
    required this.correctAnswerIndex,
  });
}

final List<Question3> question3s = [
  Question3(
    question3Text: "What is the capital of usa?",
    answers: ["Berlin", "Paris", "Madrid", "Lisbon"],
    correctAnswerIndex: 1,
  ),
  // Add 4 more Question3s
  Question3(
    question3Text: "Who wrote 'Hamlet'?",
    answers: ["Shakespeare", "Homer", "Tolstoy", "Dante"],
    correctAnswerIndex: 0,
  ),
  Question3(
    question3Text: "What is the boiling point of water?",
    answers: ["90°C", "100°C", "120°C", "80°C"],
    correctAnswerIndex: 1,
  ),
  Question3(
    question3Text: "What is the largest planet in our solar system?",
    answers: ["Mars", "Earth", "Jupiter", "Saturn"],
    correctAnswerIndex: 2,
  ),
  Question3(
    question3Text: "What is the primary language spoken in Brazil?",
    answers: ["Spanish", "English", "Portuguese", "French"],
    correctAnswerIndex: 2,
  ),
];
