import 'package:flutter/material.dart';

import 'home_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const String route = '/auth';

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: deviceWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              width: 250,
              image: AssetImage('assets/images/logo.png'),
            ),
            // Image.asset('static/images/logo.png'),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff04a3a3),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.route);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff04a3a3),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.route);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
