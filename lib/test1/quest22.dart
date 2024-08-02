class Question {
  final String questionText;
  final List<String> answers;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.answers,
    required this.correctAnswerIndex,
  });
}

final List<Question> questions = [
  Question(
    questionText: "What is the capital of France?",
    answers: ["Berlin", "Paris", "Madrid", "Lisbon"],
    correctAnswerIndex: 1,
  ),
  // Add 4 more questions
  Question(
    questionText: "Who wrote 'Hamlet'?",
    answers: ["Shakespeare", "Homer", "Tolstoy", "Dante"],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: "What is the boiling point of water?",
    answers: ["90°C", "100°C", "120°C", "80°C"],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: "What is the largest planet in our solar system?",
    answers: ["Mars", "Earth", "Jupiter", "Saturn"],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: "What is the primary language spoken in Brazil?",
    answers: ["Spanish", "English", "Portuguese", "French"],
    correctAnswerIndex: 2,
  ),
];
