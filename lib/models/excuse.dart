class Excuse {
  final String text;
  final String situation;
  final String tone;
  final DateTime createdAt;

  Excuse({
    required this.text,
    required this.situation,
    required this.tone,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'text': text,
        'situation': situation,
        'tone': tone,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Excuse.fromJson(Map<String, dynamic> json) => Excuse(
        text: json['text'],
        situation: json['situation'],
        tone: json['tone'],
        createdAt: DateTime.parse(json['createdAt']),
      );
}