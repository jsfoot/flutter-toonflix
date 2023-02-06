import 'package:flutter/material.dart';
import 'package:toonflix/screen/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true, // 전체화면으로 띄우는 효과. 뒤로가기 대신에 X표시가 뜬다.
            builder: ((context) => DetailScreen(
                  title: title,
                  thumb: thumb,
                  id: id,
                )),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(10, 10),
                      color: Colors.white.withOpacity(0.3),
                    )
                  ]),
              width: 200,
              clipBehavior: Clip.hardEdge, //자식이 부모영역 벗어나는 부분 제어
              child: Image.network(thumb),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
