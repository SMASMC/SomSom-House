import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somsomhouse/view_models/final_view_models.dart';

class Songpa extends StatelessWidget {
  const Songpa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('송파구 지도'),
      ),
      body: Center(
        child: InkWell(
          splashColor: Colors.orange,
          onTapDown: (TapDownDetails details) {
            print(
                'x좌표는 ${details.localPosition.dx} y좌표는 ${details.localPosition.dy}');

            _handleTapDown(
                context, details.localPosition.dx, details.localPosition.dy);
          },
          child: Image.asset('images/송파구.png'),
        ),
      ),
    );
  }

  //-----function-------
  _handleTapDown(BuildContext context, var dx, var dy) {
    final vm = Provider.of<FinalViewModel>(context, listen: false);
    if ((dx > 167 && dx < 213 && dy > 13 && dy < 54) ||
        (dx > 174 && dx < 199 && dy > 28 && dy < 54)) {
      vm.changeDongName('풍납동');
      Navigator.pop(context);
    } else if ((dx > 153 && dx < 165 && dy > 47 && dy < 85) ||
        (dx > 174 && dx < 198 && dy > 61 && dy < 85)) {
      vm.changeDongName('신천동');
      Navigator.pop(context);
    } else if ((dx > 218 && dx < 247 && dy > 91 && dy < 110) ||
        (dx > 238 && dx < 249 && dy > 97 && dy < 118)) {
      vm.changeDongName('오금동');
      Navigator.pop(context);
    } else if ((dx > 169 && dx < 222 && dy > 121 && dy < 136) ||
        (dx > 225 && dx < 239 && dy > 117 && dy < 132) ||
        (dx > 205 && dx < 224 && dy > 115 && dy < 136)) {
      vm.changeDongName('가락동');
      Navigator.pop(context);
    }
  }
}//end
