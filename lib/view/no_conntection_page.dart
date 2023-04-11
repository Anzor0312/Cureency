import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset("assets/noConnection.svg"),
        ),
    );
  }
}