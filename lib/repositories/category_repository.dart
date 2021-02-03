import 'package:komik_seyler/models/categories.dart';
import 'package:komik_seyler/models/category_picture.dart';
import 'package:komik_seyler/providers/api_provider.dart';
import 'package:komik_seyler/providers/provider.dart';

class CategoryRepository {
  Provider provider;

  CategoryRepository({this.provider}) {
    this.provider ??= ApiProvider();
  }

  Future<List<Category>> all() async {
    String endpoint = '/categories';
    List<Category> categories = [];

    var response = await provider.getResponse(endpoint);

    categories = categoryFromJson(response);

    return categories;
  }

  pictures(String endpoint) async {
    CategoryPicture categoryPicture;

    var response = await provider.getResponse(endpoint);

    categoryPicture = categoryPictureFromJson(response);

    return categoryPicture;
  }
}
