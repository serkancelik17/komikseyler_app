import 'package:komik_seyler/business/repositories/abstracts/model_repository.dart';

class LogRepository extends ModelRepository {
  LogRepository() : super(endPointPattern: "/devices/{device_uuid}/logs");
}
