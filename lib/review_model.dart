class Review {
  final int id;
  final int score;
  final String reason;
  final String feedback;

  const Review({
    required this.id,
    required this.score,
    required this.reason,
    required this.feedback
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'score': score,
      'reason': reason,
      'feedback': feedback
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Review{id: $id, score: $score, reason: $reason, feedback: $feedback}';
  }
}