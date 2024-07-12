class User {
  final String id;
  final String name;
  final bool goalSatisfied;

  User({
    required this.id,
    required this.name,
    required this.goalSatisfied,
  });

  static User mock() {
    return User(
      id: '1',
      name: 'Minjun',
      goalSatisfied: false,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      goalSatisfied: json['goalSatisfied'],
    );
  }
}