import 'package:komik_seyler/business/repositories/abstracts/model_repository.dart';

class OptionRepository extends ModelRepository {
  OptionRepository() : super(endPointPattern: '/devices/{device_uuid}/options');
}