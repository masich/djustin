import 'package:test/test.dart';

import 'json/json_test.dart';
import 'service/service_test.dart';

void main() {
  group('djustin tests', () {
    jsonConvertersTest();
    serviceTest();
  });
}
