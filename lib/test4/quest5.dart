class Question4 {
  final String question4Text;
  final List<String> answers;
  final int correctAnswerIndex;

  Question4({
    required this.question4Text,
    required this.answers,
    required this.correctAnswerIndex,
  });
}

final List<Question4> question4s = [
  Question4(
    question4Text: "What is the capital of libya?",
    answers: ["Berlin", "Paris", "Madrid", "Lisbon"],
    correctAnswerIndex: 1,
  ),
  // Add 4 more Question4s
  Question4(
    question4Text: "Who wrote 'Hamlet'?",
    answers: ["Shakespeare", "Homer", "Tolstoy", "Dante"],
    correctAnswerIndex: 0,
  ),
  Question4(
    question4Text: "What is the boiling point of water?",
    answers: ["90°C", "100°C", "120°C", "80°C"],
    correctAnswerIndex: 1,
  ),
  Question4(
    question4Text: "What is the largest planet in our solar system?",
    answers: ["Mars", "Earth", "Jupiter", "Saturn"],
    correctAnswerIndex: 2,
  ),
  Question4(
    question4Text: "What is the primary language spoken in Brazil?",
    answers: ["Spanish", "English", "Portuguese", "French"],
    correctAnswerIndex: 2,
  ),
];
