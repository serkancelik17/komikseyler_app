import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/repositories/repository.dart';

class PictureRepository extends Repository {
  ApiProvider _apiProvider;

  PictureRepository([this._apiProvider]) {
    this._apiProvider ??= ApiProvider();
  }
}
