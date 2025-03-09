class Policy {
  final String title;
  final String content;

  Policy({required this.title, required this.content});

  factory Policy.fromJson(Map<String, dynamic> json) {
    return Policy(
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }

  @override
  String toString() {
    return 'Policy{title: $title, content: $content}';
  }
}
