import 'package:flutter/widgets.dart';
import 'package:komik_seyler/models/picture.dart';
import 'package:komik_seyler/repositories/category_repository.dart';
import 'package:komik_seyler/repositories/picture_repository.dart';

class MatchEngine extends ChangeNotifier {
  List<Match> _matches = [];
  int currrentMatchIndex;
  int nextMatchIndex;
  CategoryRepository _categoryRepository = CategoryRepository();

  List<Match> get matches => _matches;

  set matches(List<Match> value) {
    _matches = value;
  }

  MatchEngine({List<Match> matches}) : _matches = matches {
    _matches ??= [];
    currrentMatchIndex = 0;
    nextMatchIndex = 1;
  }

  Match get currentMatch => _matches[currrentMatchIndex];
  Match get nextMatch => _matches[nextMatchIndex];

  void cycleMatch() {
    print("Decision: " + currentMatch.decision.toString());

    if (currentMatch.decision != Decision.indecided) {
      currentMatch.reset();
      currrentMatchIndex = nextMatchIndex;
      nextMatchIndex = nextMatchIndex < _matches.length - 1 ? nextMatchIndex + 1 : 0;
      notifyListeners();
    }
  }
}

class Match extends ChangeNotifier {
  final Picture picture;
  final PictureRepository _pictureRepository = PictureRepository();

  Decision decision = Decision.indecided;

  Match({this.picture});

  void nope() {
    if (decision == Decision.indecided) {
      decision = Decision.nope;
      notifyListeners();
    }
  }

  Future<bool> destroy() async {
    try {
      bool result = await _pictureRepository.destroy(pictureId: picture.id);
      return true;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> addAction({@required actionName, @required bool value}) async {
    try {
      bool result = await _pictureRepository.addAction(actionName: actionName, pictureId: picture.id, value: value);
      return result;
    } catch (e) {
      return false;
    }

    /*  if (decision == Decision.favorite) {
      decision = Decision.favorite;
      notifyListeners();
    }*/
  }

  void reset() {
    if (decision != Decision.indecided) {
      decision = Decision.indecided;
      notifyListeners();
    }
  }
}

enum Decision {
  indecided,
  nope,
  like,
  favorite,
}
