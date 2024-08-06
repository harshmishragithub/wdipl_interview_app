class Question2 {
  final String question2Text;
  final List<String> answers;
  final int correctAnswerIndex;

  Question2({
    required this.question2Text,
    required this.answers,
    required this.correctAnswerIndex,
  });
}

final List<Question2> question2 = [
  Question2(
    question2Text: "What is the capital of inidia?",
    answers: ["Berlin", "Paris", "Madrid", "Lisbon"],
    correctAnswerIndex: 1,
  ),
  // Add 4 more Question2s
  Question2(
    question2Text: "Who wrote 'Hamlet'?",
    answers: ["Shakespeare", "Homer", "Tolstoy", "Dante"],
    correctAnswerIndex: 0,
  ),
  Question2(
    question2Text: "What is the boiling point of water?",
    answers: ["90°C", "100°C", "120°C", "80°C"],
    correctAnswerIndex: 1,
  ),
  Question2(
    question2Text: "What is the largest planet in our solar system?",
    answers: ["Mars", "Earth", "Jupiter", "Saturn"],
    correctAnswerIndex: 2,
  ),
  Question2(
    question2Text: "What is the primary language spoken in Brazil?",
    answers: ["Spanish", "English", "Portuguese", "French"],
    correctAnswerIndex: 2,
  ),
];
