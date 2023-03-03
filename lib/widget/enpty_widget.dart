import 'package:flutter/cupertino.dart';

class EmptyWidget extends StatelessWidget {
  final String message;

  const EmptyWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Text(
        message,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}
