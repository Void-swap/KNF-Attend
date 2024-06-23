class Mentee {
  final String name;
  final String mentor;

  Mentee({required this.name, required this.mentor});

  factory Mentee.fromJson(Map<String, dynamic> json) {
    return Mentee(
      name: json['name'],
      mentor: json['mentor'],
    );
  }
}
