class Policy {
  final String title;
  final String content;

  Policy({required this.title, required this.content});

  // Chuyển từ JSON sang object
  factory Policy.fromJson(Map<String, dynamic> json) {
    return Policy(
      title: json['title'],
      content: json['content'],
    );
  }

  // Chuyển object sang JSON (nếu cần)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}
