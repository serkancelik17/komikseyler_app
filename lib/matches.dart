import 'package:flutter/widgets.dart';
import 'package:komik_seyler/models/picture.dart';
import 'package:komik_seyler/repositories/picture_repository.dart';

class MatchEngine extends ChangeNotifier {
  final List<Match> _matches;
  int _currrentMatchIndex;
  int _nextMatchIndex;

  MatchEngine({
    List<Match> matches,
  }) : _matches = matches {
    _currrentMatchIndex = 0;
    _nextMatchIndex = 1;
  }

  Match get currentMatch => _matches[_currrentMatchIndex];
  Match get nextMatch => _matches[_nextMatchIndex];

  void cycleMatch() {
    if (currentMatch.decision != Decision.indecided) {
      currentMatch.reset();
      _currrentMatchIndex = _nextMatchIndex;
      _nextMatchIndex = _nextMatchIndex < _matches.length - 1 ? _nextMatchIndex + 1 : 0;
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

  Future<bool> favorite({@required bool value}) async {
    try {
      bool result = await _pictureRepository.favorite(pictureId: picture.id, value: value);
      return true;
    } catch (e) {
      return false;
    }

    /*  if (decision == Decision.favorite) {
      decision = Decision.favorite;
      notifyListeners();
    }*/
  }

  Future<bool> like({@required bool value}) async {
    try {
      bool result = await _pictureRepository.like(pictureId: picture.id, value: value);
      return true;
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
