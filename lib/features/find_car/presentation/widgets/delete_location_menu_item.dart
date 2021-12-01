import 'package:flutter/material.dart';

class DeleteLocationMenuItem extends StatelessWidget {
  const DeleteLocationMenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.delete,
          color: Colors.red,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          'Delete',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
