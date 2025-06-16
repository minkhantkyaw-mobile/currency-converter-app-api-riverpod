class Rate {
  final String? info;
  final String? description;
  final int? timestamp;
  final Map<String, String> rates;

  const Rate({
    required this.info,
    required this.description,
    required this.timestamp,
    required this.rates,
  });

  factory Rate.fromJson(Map<String, dynamic> json) {
    final rawRates = json['rates'];

    Map<String, String> parsedRates = {};
    if (json['rates'] is Map) {
      // Normal case: rates is a map
      Map<String, dynamic> ratesMap = json['rates'] as Map<String, dynamic>;
      // Convert dynamic values to String (assuming all are convertible)
      parsedRates = ratesMap.map(
        (key, value) => MapEntry(key, value.toString()),
      );
    } else if (json['rates'] is List) {
      // Sometimes rates is an empty list []
      // Just keep rates empty
      parsedRates = {};
    } else {
      // Unexpected type, keep empty or throw error
      parsedRates = {};
    }

    return Rate(
      info: json['info'] ?? '',
      description: json['description'] ?? '',
      timestamp: int.tryParse(json['timestamp'].toString()) ?? 0,
      rates: parsedRates,
    );
  }
}
