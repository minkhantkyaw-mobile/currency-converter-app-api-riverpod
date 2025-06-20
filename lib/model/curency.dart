class Currency {
  final String? info;
  final String? description;
  final Map<String, String> currency;

  const Currency({
    required this.info,
    required this.description,
    required this.currency,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    try {
      return Currency(
        info: json['info'],
        description: json['description'],
        currency: Map<String, String>.from(json['currencies']),
      );
    } catch (e) {
      print("There is an error : $e");
    }
    return Currency(
      info: json['info'],
      description: json['description'],
      currency: Map<String, String>.from(json['currencies']),
    );
  }
}

const currencies = {
  "USD": "United State Dollar",
  "EUR": "Euro",
  "SGD": "Singapore Dollar",
  "GBP": "Pound Sterling",
  "CHF": "Swiss Franc",
  "JPY": "Japanese Yen",
  "AUD": "Australian Dollar",
  "BDT": "Bangladesh Taka",
  "BND": "Brunei Dollar",
  "KHR": "Cambodian Riel",
  "CAD": "Canadian Dollar",
  "CNY": "Chinese Yuan",
  "HKD": "Hong Kong Dollar",
  "INR": "Indian Rupee",
  "IDR": "Indonesian Rupiah",
  "KRW": "Korean Won",
  "LAK": "Lao Kip",
  "MYR": "Malaysian Ringgit",
  "NZD": "New Zealand Dollar",
  "PKR": "Pakistani Rupee",
  "PHP": "Philippines Peso",
  "LKR": "Sri Lankan Rupee",
  "THB": "Thai Baht",
  "VND": "Vietnamese Dong",
  "BRL": "Brazilian Real",
  "CZK": "Czech Koruna",
  "DKK": "Danish Krone",
  "EGP": "Egyptian Pound",
  "ILS": "Israeli Shekel",
  "KES": "Kenya Shilling",
  "KWD": "Kuwaiti Dinar",
  "NPR": "Nepalese Rupee",
  "NOK": "Norwegian Kroner",
  "RUB": "Russian Rouble",
  "SAR": "Saudi Arabian Riyal",
  "RSD": "Serbian Dinar",
  "ZAR": "South Africa Rand",
  "SEK": "Swedish Krona",
};
