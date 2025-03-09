class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});

  // Chuyển từ JSON sang object
  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
      question: json['question'],
      answer: json['answer'],
    );
  }

  // Chuyển object sang JSON (nếu cần)
  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
    };
  }

  @override
  String toString() {
    return 'FAQ(question: $question, answer: $answer)';
  }
}
