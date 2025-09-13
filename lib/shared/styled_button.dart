import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    super.key,
    required this.child,
    required this.onPressed,
    });

    final Widget child;
    final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
    
      onPressed: onPressed,
      child: Container(
        clipBehavior: Clip.none,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey
        ),
        child: child,
      ),
    );
  }
}