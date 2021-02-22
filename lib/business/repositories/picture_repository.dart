import 'package:komik_seyler/business/providers/api_provider.dart';
import 'package:komik_seyler/business/repositories/abstracts/model_repository.dart';

class PictureRepository extends ModelRepository {
  ApiProvider _apiProvider;

  PictureRepository([this._apiProvider]) {
    this._apiProvider ??= ApiProvider();
  }
}
