import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluid_layout/fluid_layout.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:syntax_highlighter/syntax_highlighter.dart';

import 'custom_card.dart';

void main() => runApp(SortingMethods());

class SortingMethods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          cardTheme: CardTheme(
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          primarySwatch: Colors.indigo,
          canvasColor: Color(0xFFF5F6FA)),
      home: LayoutApp(),
    );
  }
}

class LayoutApp extends StatefulWidget {
  LayoutApp({Key key}) : super(key: key);

  @override
  _LayoutAppState createState() => _LayoutAppState();
}

class _LayoutAppState extends State<LayoutApp> with TickerProviderStateMixin {
  String sotring = 'Insertion';
  bool _isVisible = false;
  Sorting sortingData;
  GifController controller_random,
      controller_sorted,
      controller_reversed,
      controller_unique;

  @override
  void initState() {
    controller_random = GifController(vsync: this);
    controller_sorted = GifController(vsync: this);
    controller_reversed = GifController(vsync: this);
    controller_unique = GifController(vsync: this);
    parseJsonFromAssets(sotring);
    super.initState();
  }

  Duration durr(frames) => Duration(milliseconds: 50 * frames);
  final SyntaxHighlighterStyle style = SyntaxHighlighterStyle.lightThemeStyle();

  parseJsonFromAssets(String select) async {
    controller_random.reset();
    controller_unique.reset();
    controller_reversed.reset();
    controller_sorted.reset();
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/$select/data.json');
    setState(() {
      sotring = select;
      sortingData = Sorting.fromJson(json.decode(data));
      _isVisible = true;
    });
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
        title: Text(sotring),
        drawer: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Insertion'),
              onTap: () => parseJsonFromAssets('Insertion'),
            ),
            ListTile(
              title: Text('Selection'),
              onTap: () => parseJsonFromAssets('Selection'),
            ),
            ListTile(
              title: Text('Bubble'),
              onTap: () => parseJsonFromAssets('Bubble'),
            ),
            ListTile(
              title: Text('Shell'),
              onTap: () => parseJsonFromAssets('Shell'),
            ),
            ListTile(
              title: Text('Merge'),
              onTap: () => parseJsonFromAssets('Merge'),
            ),
            ListTile(
              title: Text('Heap'),
              onTap: () => parseJsonFromAssets('Heap'),
            ),
            ListTile(
              title: Text('Quick'),
              onTap: () => parseJsonFromAssets('Quick'),
            ),
            // TODO Quick3 data.json
            // ListTile(
            //   title: Text('Quick3'),
            //   onTap: () => parseJsonFromAssets('Quick3'),
            // ),
          ],
        ),
        body: Visibility(
            visible: _isVisible,
            replacement: Center(child: CircularProgressIndicator()),
            child: Scaffold(
              body: FluidLayout(
                child: Builder(
                    builder: (context) => CustomScrollView(
                          slivers: <Widget>[
                            SliverToBoxAdapter(
                                child: SizedBox(
                                    height: context.fluid(35, xs: 12, s: 12))),
                            SliverFluidGrid(
                              children: [
                                FluidCell.fit(
                                    size: context.fluid(12),
                                    child: CustomCard(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                controller_random.reset();
                                                controller_unique.reset();
                                                controller_reversed.reset();
                                                controller_sorted.reset();
                                                controller_random.animateTo(
                                                    sortingData.animate_targets
                                                            .random +
                                                        .0,
                                                    duration: durr(sortingData
                                                        .animate_targets
                                                        .random));
                                                controller_unique.animateTo(
                                                    sortingData.animate_targets
                                                            .few_unique +
                                                        .0,
                                                    duration: durr(sortingData
                                                        .animate_targets
                                                        .few_unique));
                                                controller_reversed.animateTo(
                                                    sortingData.animate_targets
                                                            .reversed +
                                                        .0,
                                                    duration: durr(sortingData
                                                        .animate_targets
                                                        .reversed));
                                                controller_sorted.animateTo(
                                                    sortingData.animate_targets
                                                            .nearly_sorted +
                                                        .0,
                                                    duration: durr(sortingData
                                                        .animate_targets
                                                        .nearly_sorted));
                                              },
                                              child: Column(children: [
                                                Icon(Icons.play_arrow,
                                                    size: 40,
                                                    color: Colors.black),
                                                Text('ВСЕ',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700))
                                              ])),
                                          GestureDetector(
                                              onTap: () {
                                                controller_random.reset();
                                                controller_random.animateTo(
                                                    sortingData.animate_targets
                                                            .random +
                                                        .0,
                                                    duration: durr(sortingData
                                                        .animate_targets
                                                        .random));
                                              },
                                              child: Column(
                                                children: <Widget>[
                                                  Text('Случайный',
                                                      style: TextStyle(
                                                        color: Colors.indigo,
                                                        fontSize: 16,
                                                      )),
                                                  GifImage(
                                                    controller:
                                                        controller_random,
                                                    fit: BoxFit.fill,
                                                    image: AssetImage(
                                                        "assets/$sotring/random.gif"),
                                                  )
                                                ],
                                              )),
                                          GestureDetector(
                                              onTap: () {
                                                controller_sorted.reset();
                                                controller_sorted.animateTo(
                                                    sortingData.animate_targets
                                                            .nearly_sorted +
                                                        .0,
                                                    duration: durr(sortingData
                                                        .animate_targets
                                                        .nearly_sorted));
                                              },
                                              child: Column(children: <Widget>[
                                                Text('Отсортированый',
                                                    style: TextStyle(
                                                      color: Colors.indigo,
                                                      fontSize: 16,
                                                    )),
                                                GifImage(
                                                  controller: controller_sorted,
                                                  image: AssetImage(
                                                      "assets/$sotring/nearly_sorted.gif"),
                                                )
                                              ])),
                                          GestureDetector(
                                            onTap: () {
                                              controller_reversed.reset();
                                              controller_reversed.animateTo(
                                                  sortingData.animate_targets
                                                          .reversed +
                                                      .0,
                                                  duration: durr(sortingData
                                                      .animate_targets
                                                      .reversed));
                                            },
                                            child: Column(children: [
                                              Text('Перевернутый',
                                                  style: TextStyle(
                                                    color: Colors.indigo,
                                                    fontSize: 16,
                                                  )),
                                              GifImage(
                                                controller: controller_reversed,
                                                image: AssetImage(
                                                    "assets/$sotring/reversed.gif"),
                                              )
                                            ]),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                controller_unique.reset();
                                                controller_unique.animateTo(
                                                    sortingData.animate_targets
                                                            .few_unique +
                                                        .0,
                                                    duration: durr(sortingData
                                                        .animate_targets
                                                        .few_unique));
                                              },
                                              child: Column(children: <Widget>[
                                                Text('Повторяющийся',
                                                    style: TextStyle(
                                                      color: Colors.indigo,
                                                      fontSize: 16,
                                                    )),
                                                GifImage(
                                                  controller: controller_unique,
                                                  image: AssetImage(
                                                      "assets/$sotring/few_unique.gif"),
                                                )
                                              ])),
                                        ],
                                      ),
                                    )),
                                FluidCell.fit(
                                    size: context.fluid(6),
                                    child: CustomCard(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('АЛГОРИТМ',
                                                style: TextStyle(
                                                  color: Colors.indigo,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                )),
                                            Divider(
                                              color: Colors.white,
                                            ),
                                            RichText(
                                                text: TextSpan(
                                              style: TextStyle(
                                                  fontFamily: 'monospace',
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.0),
                                              children: <TextSpan>[
                                                DartSyntaxHighlighter(style)
                                                    .format(
                                                        sortingData.algorithm),
                                              ],
                                            ))
                                          ]),
                                    )),
                                FluidCell.fit(
                                    size: context.fluid(6, m: 6, s: 6, xs: 6),
                                    child: CustomCard(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: sortingData.discussion
                                              .map((line) => Column(
                                                    children: <Widget>[
                                                      Divider(
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        line,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            height: 1.5),
                                                      )
                                                    ],
                                                  ))
                                              .toList()
                                                ..insert(
                                                    0,
                                                    Column(
                                                      children: <Widget>[
                                                        Text('ОБСУЖДЕНИЕ',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.indigo,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 16,
                                                            ))
                                                      ],
                                                    ))),
                                    )),
                                FluidCell.fit(
                                  size: context.fluid(6, m: 6, s: 6, xs: 6),
                                  child: CustomCard(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: sortingData.properties
                                              .map((line) => Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Divider(
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        '- ' + line,
                                                      )
                                                    ],
                                                  ))
                                              .toList()
                                                ..insert(
                                                    0,
                                                    Column(
                                                      children: <Widget>[
                                                        Text('СВОЙСТВА',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.indigo,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 16,
                                                            ))
                                                      ],
                                                    )))),
                                ),
                                FluidCell.fit(
                                    size: context.fluid(6),
                                    child: CustomCard(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                          Text('ЭФФЕКТИВНОСТЬ',
                                              style: TextStyle(
                                                color: Colors.indigo,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              )),
                                          Divider(
                                            color: Colors.white,
                                          ),
                                          // TODO обновление рейтинга рейтинга
                                          SmoothStarRating(
                                              allowHalfRating: true,
                                              isReadOnly: true,
                                              starCount: 5,
                                              size: 40.0,
                                              rating: sortingData.efficiency,
                                              color: Color(0xffFFCC00),
                                              borderColor: Color(0xffFFCC00),
                                              filledIconData: Icons.star,
                                              halfFilledIconData:
                                                  Icons.star_half,
                                              defaultIconData:
                                                  Icons.star_border,
                                              spacing: 2.0)
                                        ]))),
                              ],
                            ),
                            SliverToBoxAdapter(child: SizedBox(height: 40)),
                          ],
                        )),
              ),
            )));
  }
}

class AnimateTargets {
  int random, nearly_sorted, reversed, few_unique;

  AnimateTargets(
      this.random, this.nearly_sorted, this.reversed, this.few_unique);

  factory AnimateTargets.fromJson(dynamic json) => AnimateTargets(
      json['random'],
      json['nearly_sorted'],
      json['reversed'],
      json['few_unique']);
}

class Sorting {
  String algorithm;
  List<String> discussion;
  List<String> properties;
  double efficiency;
  AnimateTargets animate_targets;

  Sorting(this.algorithm, this.discussion, this.properties, this.efficiency,
      this.animate_targets);

  factory Sorting.fromJson(dynamic json) => Sorting(
      json['algorithm'] as String,
      List.from(json['discussion']),
      List.from(json['properties']),
      json['efficiency'] as double,
      AnimateTargets.fromJson(json['animate_targets']));
}
