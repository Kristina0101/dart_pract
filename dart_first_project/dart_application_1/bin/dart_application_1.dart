import 'package:dart_application_1/dart_application_1.dart' as dart_application_1;

void main(List<String> arguments) {
  stdout.write('Введите что-то: ');
  String? input = stdin.readLineSync();
 
  stdout.writeln('Вы ввели: $input');
}
