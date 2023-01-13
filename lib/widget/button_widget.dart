import 'package:etransact_vendor/constants.dart';
import 'package:etransact_vendor/model/palette.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.kTeal,
          shape: kRoundedBorder,
          minimumSize: const Size.fromHeight(50),
        ),
        child: buildContent(),
        onPressed: onClicked,
      );

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 16),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      );
}
