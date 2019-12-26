import 'dart:ui';
import 'dart:io';

import 'package:Drawweee/painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



enum SelectedMode { StrokeWidth, Opacity, Color }

class Draw extends StatefulWidget {
  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  Color pickerColor = Colors.black;
  List<DrawingPoints> points = List();
  bool showBottomList = false;

  double strokeWidth = 3.0;
  Color selectedColor = Colors.black;
  double opacity = 1.0;
  StrokeCap strokeCap = StrokeCap.butt;

  SelectedMode selectedMode = SelectedMode.StrokeWidth;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.deepPurpleAccent,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    final _iconSize = 32.0;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.pink.withAlpha(250)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        padding: const EdgeInsets.all(4),
                        icon: Icon(Icons.album,
                            size: _iconSize, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            if (selectedMode == SelectedMode.StrokeWidth) {
                              showBottomList = !showBottomList;
                            }
                            selectedMode = SelectedMode.StrokeWidth;
                          });
                        },
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(4),
                        icon: Icon(Icons.opacity,
                            size: _iconSize, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            if (selectedMode == SelectedMode.Opacity) {
                              showBottomList = !showBottomList;
                            }
                            selectedMode = SelectedMode.Opacity;
                          });
                        },
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(4),
                        icon: Icon(Icons.color_lens,
                            size: _iconSize, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            if (selectedMode == SelectedMode.Color) {
                              showBottomList = !showBottomList;
                            }
                            selectedMode = SelectedMode.Color;
                          });
                        },
                      ),
                      IconButton(
                          padding: const EdgeInsets.all(4),
                          icon: Icon(Icons.clear,
                              size: _iconSize, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              showBottomList = false;
                              points.clear();
                            });
                          }),
                    ],
                  ),
                  Visibility(
                    visible: showBottomList,
                    child: (selectedMode == SelectedMode.Color)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: getColorList(),
                          )
                        : Slider(
                            value: (selectedMode == SelectedMode.StrokeWidth)
                                ? strokeWidth
                                : opacity,
                            max: (selectedMode == SelectedMode.StrokeWidth)
                                ? 50.0
                                : 1.0,
                            min: 0.0,
                            onChanged: (val) {
                              setState(() {
                                if (selectedMode == SelectedMode.StrokeWidth)
                                  strokeWidth = val;
                                else
                                  opacity = val;
                              });
                            }),
                  ),
                ],
              ),
            )),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            points.add(DrawingPoints(
                points: renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = selectedColor.withOpacity(opacity)
                  ..strokeWidth = strokeWidth));
          });
        },
        onPanStart: (details){
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            points.add(DrawingPoints(
                points: renderBox.globalToLocal(details.globalPosition),
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = selectedColor.withOpacity(opacity)
                  ..strokeWidth = strokeWidth));
          });
        },
        onPanEnd: (details){
          setState(() {
            points.add(null);
          });
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: DrawingPainter(
            pointsList: points
          ),
        )
      ),
    );
  }

  getColorList() {
    List<Widget> listWidget = List();
    for (Color color in colors) {
      listWidget.add(colorCircle(color));
    }
    return listWidget;
  }

  Widget colorCircle(Color color) {
    return GestureDetector(
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 48.0),
          color: color,
          height: 24,
          width: 24,
        ),
      ),
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
    );
  }
}
