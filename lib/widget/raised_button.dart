import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:votingapp/core/theme/colors.dart';

class RaisedButton extends StatefulWidget {
  const RaisedButton(
      {super.key,
      required this.onPressed,
      required this.color,
      required this.label,
      this.icons});

  final VoidCallback onPressed;
  final Color color;
  final String label;
  final IconData? icons;
  @override
  State<RaisedButton> createState() => _RaisedButtonState();
}

class _RaisedButtonState extends State<RaisedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icons),
            const Gap(10),
            Text(
              widget.label,
              style: const TextStyle(
                  color: whiteColor, fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
