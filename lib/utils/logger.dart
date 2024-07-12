import 'package:logger/logger.dart';

final printer = PrettyPrinter(
  printEmojis: true,
  lineLength: 120,
  colors: true,
  printTime: false,
  methodCount: 0,
);

final logger = Logger(
  printer: printer,
  filter: null,
  output: null,
);

void logRepository(String message) => logger.d("[REPOSITORY] : $message");
void logProvider(String message) => logger.d("<PROVIDER> : $message");


