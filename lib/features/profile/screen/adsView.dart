import 'package:flutter/material.dart';
import 'package:luna_demo/commons/color%20constansts.dart';

class adsView extends StatefulWidget {
  const adsView({super.key});

  @override
  State<adsView> createState() => _adsViewState();
}

class _adsViewState extends State<adsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallette.secondaryBrown,
    );
  }
}
