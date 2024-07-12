import 'package:uuid/uuid.dart';

String generateUUID() {
  const uuid = Uuid();
  return uuid.v4();
}