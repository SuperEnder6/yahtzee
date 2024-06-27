import 'dart:math';

import 'package:flutter/material.dart';
import "package:yahtzee/yahtzee.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiceMe',
      home: SafeArea(child: MyHomePage(title: '快艇骰子')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: drawAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            drawDicesRow(),
            drawHoldButtonsRow(),
            drawRollButtonRow(),
            drawResultsPane(),
          ],
        ),
      ),
    );
  }

  Padding drawResultsPane() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        drawCategoryColumn(),
        drawValueColumn(),
        drawStoreButtonsColumn()
      ],
    ),
  );

  Column drawCategoryColumn() => Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: drawAllCategoryTexts(),
  );

  Column drawValueColumn() => Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: showAllScores(),
  );

  Column drawStoreButtonsColumn() => Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: rollTime==0?drawNoStoreButtons():drawAllStoreButtons(),
  );

  List<Widget> drawAllCategoryTexts() => <Widget>[
    drawSingleNormalText('1點'),
    drawSingleNormalText('2點'),
    drawSingleNormalText('3點'),
    drawSingleNormalText('4點'),
    drawSingleNormalText('5點'),
    drawSingleNormalText('6點'),
    drawSingleBoldText('總和'),
    drawSingleNormalText('獎勵'),
    drawSingleBoldText('總和'),
    drawSingleNormalText(''),
    drawSingleNormalText('三條'),
    drawSingleNormalText('四條'),
    drawSingleNormalText('小順'),
    drawSingleNormalText('大順'),
    drawSingleNormalText('葫蘆'),
    drawSingleNormalText('快艇'),
    drawSingleNormalText('機會'),
    drawSingleBoldText('總和'),
    drawSingleNormalText(''),
    drawSingleBoldText('最終總分'),
  ];

  List<Widget> showAllScores() => <Widget>[
    showScoreForSingles(1),
    showScoreForSingles(2),
    showScoreForSingles(3),
    showScoreForSingles(4),
    showScoreForSingles(5),
    showScoreForSingles(6),
    drawSingleBoldValue(Yahtzee.calculateSumOfSingles()),
    drawSingleBoldValue(Yahtzee.calculateBonus()),
    drawSingleBoldValue(Yahtzee.calculateSumOfSinglesAndBonus()),
    drawSingleNormalText(''),
    showScoreForThreeOfKind(Yahtzee.getScoreKind(3)),
    showScoreForFourOfKind(Yahtzee.getScoreKind(4)),
    showScoreForSmallStraight(Yahtzee.getScoreStraight(4)),
    showScoreForLargeStraight(Yahtzee.getScoreStraight(5)),
    showScoreForFullHouse(Yahtzee.getScoreFullHouse()),
    showScoreForYahtzee(Yahtzee.getScoreYahtzee()),
    showScoreForChance(Yahtzee.getScoreTotal()),
    drawSingleBoldValue(Yahtzee.calculateSumOfSpecials()),
    drawSingleNormalText(''),
    drawSingleBoldValue(Yahtzee.calculateSumOfSums())
  ];

  List<Widget> drawNoStoreButtons() => <Widget>[
    drawStoreDivider()
  ];

  List<Widget> drawAllStoreButtons() => <Widget>[
    singles[0] == NO_VALUE ? drawStoreSinglesButton(1) : drawStoreDivider(),
    singles[1] == NO_VALUE ? drawStoreSinglesButton(2) : drawStoreDivider(),
    singles[2] == NO_VALUE ? drawStoreSinglesButton(3) : drawStoreDivider(),
    singles[3] == NO_VALUE ? drawStoreSinglesButton(4) : drawStoreDivider(),
    singles[4] == NO_VALUE ? drawStoreSinglesButton(5) : drawStoreDivider(),
    singles[5] == NO_VALUE ? drawStoreSinglesButton(6) : drawStoreDivider(),
    drawStoreDivider(),
    drawStoreDivider(),
    drawStoreDivider(),
    drawStoreDivider(),
    threeOfKind == NO_VALUE ? drawStoreThreeOfKindButton() : drawStoreDivider(),
    fourOfKind == NO_VALUE ? drawStoreFourOfKindButton() : drawStoreDivider(),
    smStraight == NO_VALUE ? drawStoreSmallStraightButton() : drawStoreDivider(),
    laStraight == NO_VALUE ? drawStoreLargeStraightButton() : drawStoreDivider(),
    fullHouse == NO_VALUE ? drawStoreFullHouseButton() : drawStoreDivider(),
    yahtzee == NO_VALUE ? drawStoreYahtzeeButton() : drawStoreDivider(),
    chance == NO_VALUE ? drawStoreChanceButton() : drawStoreDivider(),
    drawStoreDivider(),
    drawStoreDivider(),
    drawStoreDivider()
  ];

  SizedBox drawStoreSinglesButton(int number) => SizedBox(
    height: ROW_HEIGHT,
    child: MaterialButton(
        child: Text("填入",style: TextStyle(fontSize: 18)),
        color: Colors.white,
        onPressed: () {
          setState(() {
            rollTime = 0;
            hold[0] = false;hold[1] = false;hold[2] = false;hold[3] = false;hold[4] = false;
            singles[number - 1] = Yahtzee.getScoreSingles(number);
          });
        }),
  );

  SizedBox drawStoreSmallStraightButton() => SizedBox(
    height: ROW_HEIGHT,
    child: MaterialButton(
      
      child: Text("填入",style: TextStyle(fontSize: 18)),
        color: Colors.white,
      onPressed: () {
        setState(() {
          rollTime = 0;
          hold[0] = false;hold[1] = false;hold[2] = false;hold[3] = false;hold[4] = false;
          smStraight = Yahtzee.getScoreStraight(4);
        });
      },
    ),
  );

  SizedBox drawStoreLargeStraightButton() => SizedBox(
    height: ROW_HEIGHT,
    child: MaterialButton(
      child: Text("填入",style: TextStyle(fontSize: 18)),
        color: Colors.white,
      onPressed: () {
        setState(() {
          rollTime = 0;
          hold[0] = false;hold[1] = false;hold[2] = false;hold[3] = false;hold[4] = false;
          laStraight = Yahtzee.getScoreStraight(5);
        });
      },
    ),
  );

  SizedBox drawStoreThreeOfKindButton() => SizedBox(
    height: ROW_HEIGHT,
    child: MaterialButton(
      child: Text("填入",style: TextStyle(fontSize: 18)),
        color: Colors.white,
      onPressed: () {
        setState(() {
          rollTime = 0;
          hold[0] = false;hold[1] = false;hold[2] = false;hold[3] = false;hold[4] = false;
          threeOfKind = Yahtzee.getScoreKind(3);
        });
      },
    ),
  );

  SizedBox drawStoreFourOfKindButton() => SizedBox(
    height: ROW_HEIGHT,
    child: MaterialButton(
      child: Text("填入",style: TextStyle(fontSize: 18)),
        color: Colors.white,
      onPressed: () {
        setState(() {
          rollTime = 0;
          hold[0] = false;hold[1] = false;hold[2] = false;hold[3] = false;hold[4] = false;
          fourOfKind = Yahtzee.getScoreKind(4);
        });
      },
    ),
  );

  SizedBox drawStoreYahtzeeButton() => SizedBox(
    height: ROW_HEIGHT,
    child: MaterialButton(
      child: Text("填入",style: TextStyle(fontSize: 18)),
        color: Colors.white,
      onPressed: () {
        setState(() {
          rollTime = 0;
          hold[0] = false;hold[1] = false;hold[2] = false;hold[3] = false;hold[4] = false;
          yahtzee = Yahtzee.getScoreYahtzee();
        });
      },
    ),
  );

  SizedBox drawStoreFullHouseButton() => SizedBox(
    height: ROW_HEIGHT,
    child: MaterialButton(
      child: Text("填入",style: TextStyle(fontSize: 18)),
        color: Colors.white,
      onPressed: () {
        setState(() {
          rollTime = 0;
          hold[0] = false;hold[1] = false;hold[2] = false;hold[3] = false;hold[4] = false;
          fullHouse = Yahtzee.getScoreFullHouse();
        });
      },
    ),
  );

  SizedBox drawStoreChanceButton() => SizedBox(
    height: ROW_HEIGHT,
    child: MaterialButton(
      child: Text("填入",style: TextStyle(fontSize: 18)),
        color: Colors.white,
      onPressed: () {
        setState(() {
          rollTime = 0;
          hold[0] = false;hold[1] = false;hold[2] = false;hold[3] = false;hold[4] = false;
          chance = Yahtzee.getScoreTotal();
        });
      },
    ),
  );

  SizedBox drawStoreDivider() => SizedBox(height: ROW_HEIGHT);

  SizedBox showScoreForSingles(int number) =>
      (singles[number - 1] >= 0)
          ? drawSingleNormalValue(singles[number - 1])
          : drawSinglePossibleValue(Yahtzee.getScoreSingles(number));

  SizedBox showScoreForChance(int number) => chance == NO_VALUE
      ? drawSinglePossibleValue(number)
      : drawSingleNormalValue(chance);

  showScoreForFullHouse(int number) => fullHouse == NO_VALUE
      ? drawSinglePossibleValue(number)
      : drawSingleNormalValue(fullHouse);

  showScoreForSmallStraight(int number) => smStraight == NO_VALUE
      ? drawSinglePossibleValue(number)
      : drawSingleNormalValue(smStraight);

  showScoreForLargeStraight(int number) => laStraight == NO_VALUE
      ? drawSinglePossibleValue(number)
      : drawSingleNormalValue(laStraight);

  showScoreForThreeOfKind(int number) => threeOfKind == NO_VALUE
      ? drawSinglePossibleValue(number)
      : drawSingleNormalValue(threeOfKind);

  showScoreForFourOfKind(int number) => fourOfKind == NO_VALUE
      ? drawSinglePossibleValue(number)
      : drawSingleNormalValue(fourOfKind);

  showScoreForYahtzee(int number) => yahtzee == NO_VALUE
      ? drawSinglePossibleValue(number)
      : drawSingleNormalValue(yahtzee);

  SizedBox drawSingleNormalValue(int value) =>
      drawSingleValue(value, false, true);

  SizedBox drawSingleBoldValue(int value) => drawSingleValue(value, true, true);

  SizedBox drawSinglePossibleValue(int value) =>
      drawSingleValue(value, false, false);

  SizedBox drawSingleValue(int value, bool bold, bool stored) => SizedBox(
    height: ROW_HEIGHT,
    child: Text(
      value.toString(),
      style: TextStyle(
          fontSize: CATEGORY_TEXT_SIZE,
          color: stored ? Colors.white : Colors.red,
          backgroundColor: stored ? Colors.red : Colors.white,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal),
    ),
  );

  SizedBox drawSingleNormalText(String text) => drawSingleText(text, false);

  SizedBox drawSingleBoldText(String text) => drawSingleText(text, true);

  SizedBox drawSingleText(String text, bool bold) => SizedBox(
    height: ROW_HEIGHT,
    child: Text(
      text,
      style: TextStyle(
          fontSize: CATEGORY_TEXT_SIZE,
          color: Colors.white,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal),
    ),
  );

  AppBar drawAppBar() => AppBar(
    title: Text(
      widget.title,
    ),
    backgroundColor: Colors.blueGrey.shade800,
  );

  Row drawRollButtonRow() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      drawRollButton(),
    ],
  );

  Row drawDicesRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      drawDice(0),
      drawDice(1),
      drawDice(2),
      drawDice(3),
      drawDice(4),
    ],
  );

  Row drawHoldButtonsRow() => Row(
    children: <Widget>[
      drawHoldButton(0),
      drawHoldButton(1),
      drawHoldButton(2),
      drawHoldButton(3),
      drawHoldButton(4),
    ],
  );

  void rollDices() => setState(() {
    if(rollTime<3){
      rollTime++;
      for (int i = 0; i < NUMBER_OF_DICES; i++) {
        if (!hold[i]) values[i] = Random().nextInt(6) + 1;
      }
    }
  });

  void holdOrRollDice(int i) => setState(() {
    if(rollTime!=0) hold[i] = !hold[i];
  });

  Expanded drawDice(int num) => Expanded(
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Image(
        height: 50,
        image: AssetImage('images/Side${values[num]}.png'),
      ),
    ),
  );

  Expanded drawHoldButton(int num) => Expanded(
    child: MaterialButton(
      color: hold[num] ? Colors.red : Colors.white,
      child: Text(
        hold[num] ? '鎖定' : "選擇",
        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: hold[num] ? Colors.white : Colors.red),
      ),
      onPressed: () => holdOrRollDice(num),
    ),
  );

  MaterialButton drawRollButton() => MaterialButton(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    color: Colors.white,
    onPressed: rollDices,
    child: Text(
      rollTime==0?'擲骰':('重擲(${3-rollTime})'),
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
    ),
  );
}