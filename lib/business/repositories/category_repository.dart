import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/repositories/abstracts/model_repository.dart';
import 'package:komik_seyler/business/repositories/device_repository.dart';
import 'package:komik_seyler/business/repositories/repository.dart';

class CategoryRepository extends ModelRepository implements Repository {
  ApiProvider provider;
  DeviceRepository deviceRepository;

  CategoryRepository({this.provider, this.deviceRepository}) {
    this.provider ??= ApiProvider();
    this.deviceRepository ??= DeviceRepository();
  }
}
