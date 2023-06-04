import 'package:alpha/core/repositories/core_repository_injection.dart';
import 'package:alpha/core/services/core_service_injection.dart';

class DependencyContainer {
  static void setup() {
    CoreRepositoryInjection.setup();
    CoreServiceInjection.setup();
  }
}
