import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoBack extends StatelessWidget {
  const GoBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        ClipOval(
          child: Material(
            color: Colors.black, // Button color
            child: InkWell(
              splashColor: Colors.white, // Splash color

              child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            ),
          ),
        ), Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            "Geri Dön",
            style: TextStyle(fontSize: 15),
          ),
        )

      ],
    );
  }
}
