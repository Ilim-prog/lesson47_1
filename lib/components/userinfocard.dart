import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  final String name;
  final String value;
  final bool istitle;

  const UserInfoCard({
    Key? key,
    required this.name,
    required this.value,
    this.istitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            name,
            style: TextStyle(
              fontWeight: istitle ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: istitle ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
