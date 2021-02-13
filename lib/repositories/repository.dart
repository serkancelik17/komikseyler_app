import 'package:flutter/material.dart';
import 'package:komik_seyler/models/picture.dart';
import 'package:komik_seyler/models/section.dart';

abstract class Repository {
  Future<List<Picture>> pictures({@required Section section, int page = 1, int limit = 20});
}
