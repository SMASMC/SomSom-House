import 'package:flutter/material.dart';

class Yangcheon extends StatelessWidget {
  const Yangcheon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('양천구 지도'),
      ),
      body: Center(
        child: InkWell(
          splashColor: Colors.orange,
          onTapDown: (TapDownDetails details) {
            _handleTapDown(
                context, details.localPosition.dx, details.localPosition.dy);
          },
          child: Image.asset('images/양천구.png'),
        ),
      ),
    );
  }

  //-----function-------
  _handleTapDown(BuildContext context, var dx, var dy) {
    // final vm = Provider.of<FinalViewModel>(context, listen: false);
    if ((dx > 116 && dx < 196 && dy > 176 && dy < 233) ||
        (dx > 199 && dx < 254 && dy > 116 && dy < 209) ||
        (dx > 265 && dx < 315 && dy > 140 && dy < 230)) {
      // vm.changeDongName('신정동');
      Navigator.pop(context);
    }
  }
}//end
