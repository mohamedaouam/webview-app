import 'package:flutter/material.dart';
import 'package:webviewapp/parameters.dart';

class ErrorNetworkPage extends StatelessWidget {
  const ErrorNetworkPage(BuildContext context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: NE_BACKGROUND,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              NE_ICON,
              size: 100,
              color: NE_ICON_COLOR,
            ),
            const SizedBox(height: 50),
            Text(
              ER_HTEXT,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: NE_HEADING_COLOR,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              ER_PTEXT,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: NE_TEXT_COLOR,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(ER_BTNTEXT),
                style: ElevatedButton.styleFrom(
                  primary: NE_BTN_COLOR,
                  padding: const EdgeInsets.all(15),
                ),
              ),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
