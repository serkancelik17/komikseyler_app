import 'package:flutter/cupertino.dart';

class ImageNetworkAtom extends StatelessWidget {
  final String url;

  ImageNetworkAtom({@required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(url);
  }
}
