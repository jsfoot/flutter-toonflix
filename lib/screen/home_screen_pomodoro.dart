import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes; // 카운트 초기화 시간
  late Timer timer; // 버튼을 누를 때 초기화할 것이므로, late를 사용해 당장 초기화 하지 않아도 됨을 선언하자.
  bool isRunning = false;
  int totalPomodoros = 0;

  void onTick(Timer timer) {
    //Timer.periodic 함수는 Timer를 받아야 하므로 이를 넣지 않으면 onTick함수를 사용하는 onStartPressed 함수에서 에러가 난다.
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);

    return duration.toString().split(".").first.substring(2, 7);
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1),
        onTick); // onTick() 형태로 넣으면 시작하자마자 즉시 실행되니 괄호를 빼야한다.
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    // 일시정지버튼 누르면 타이머 캔슬되고 상태 바뀜
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onClickReset() {
    timer.cancel();
    setState(() {
      isRunning = false;
      totalSeconds = twentyFiveMinutes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context)
          .backgroundColor, // main.dart의 ThemeData의 property를 가져왔다.
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment:
                  Alignment.bottomCenter, // 위에 붙어있어 노치에 가려지지 않게 아래로 내려서 정렬
              child: Text(
                format(
                    totalSeconds), // format함수는 totalSeconds를 받아서 Duration의 분:초 부분문 리턴한다.
                style: TextStyle(
                  color: Theme.of(context).cardColor.withOpacity(1),
                  fontSize: 89,
                  fontWeight:
                      FontWeight.w600, // main.dart의 ThemeData의 property를 가져왔다.
                ),
              ),
            ),
          ),
          Flexible(
            // const를 지워줘야 한다.
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 98,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    icon: Icon(isRunning
                        ? Icons.pause_circle
                        : Icons.play_circle_outline),
                  ),
                  IconButton(
                    iconSize: 40,
                    color: Theme.of(context).cardColor,
                    onPressed: onClickReset,
                    icon: const Icon(
                      Icons.restore,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoros",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
