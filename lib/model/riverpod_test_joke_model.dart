class RiverpodTestJokeModel {
  final String type;
  final String setup;
  final String punchline;
  final int id;

  RiverpodTestJokeModel({
    required this.type,
    required this.setup,
    required this.punchline,
    required this.id,
  });

  factory RiverpodTestJokeModel.fromJson(Map<String, dynamic> json) =>
      RiverpodTestJokeModel(
        type: json['type'],
        setup: json['setup'],
        punchline: json['punchline'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
    'type': type,
    'setup': setup,
    'punchline': punchline,
    'id': id,
  };
}
