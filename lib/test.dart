import 'package:http/http.dart' as http;

Future<void> fetchAlbum() async {
  var response = await http.get(
    Uri.parse('https://forex.cbm.gov.mm/api/latest'),
  );
  print(response.body);
}

void main() async {
  await fetchAlbum();
}
