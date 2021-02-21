import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/mixins/section_mixin.dart';
import 'package:komik_seyler/business/models/mixins/view_mixin.dart';

abstract class Repositoriable {
  Future<List<ViewMixin>> views({@required SectionMixin section, int page = 1, int limit = 20});
}
