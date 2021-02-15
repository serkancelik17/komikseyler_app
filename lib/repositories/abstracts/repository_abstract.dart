import 'package:flutter/material.dart';
import 'package:komik_seyler/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/models/picture.dart';

abstract class RepositoryAbstract {
  Future<List<Picture>> pictures({@required SectionAbstract section, int page = 1, int limit = 20});
}
