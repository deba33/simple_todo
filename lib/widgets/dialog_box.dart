import 'package:flutter/material.dart';
import './buttons.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback onSaved;
  final VoidCallback onCancelled;
  const DialogBox({
    super.key,
    required this.controller,
    required this.onSaved,
    required this.onCancelled,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a new task',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  buttonName: 'Cancel',
                  buttonColor: Theme.of(context).errorColor,
                  onPressed: onCancelled,
                ),
                const SizedBox(
                  width: 10,
                ),
                MyButton(
                  buttonName: 'Save',
                  buttonColor: Theme.of(context).primaryColor,
                  onPressed: onSaved,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
