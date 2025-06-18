// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:http/http.dart' as http;

Future<void> fetchAlbum() async {
  var response = await http.get(
    Uri.parse('https://forex.cbm.gov.mm/api/latest'),
  );
  print(response.body);
}

class Person {
  final String name;
  final int age;
  Person({required this.name, required this.age});

  Person copyWith({String? name, int? age}) {
    return Person(name: name ?? this.name, age: age ?? this.age);
  }
}

void main() {
  //await fetchAlbum();
  Person person = Person(name: "mkk1", age: 23);
  print(person.name);
  person = person.copyWith(name: "MKK2", age: 22);
  print(person.name);
}
