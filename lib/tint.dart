import 'package:flutter/widgets.dart';

class Tint extends SingleChildRenderObjectWidget {
  const Tint({
    Key key,
    @required this.color,
    Widget child
  }) : assert(color != null),
       super(key: key, child: child);

  final Color color;

  @override
  RenderObject createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    return null;
  }
}