import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TODOBottomSheet extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? saveNewTask;
  const TODOBottomSheet({
    super.key,
    required this.controller,
    this.saveNewTask,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(35),
              ],
              textInputAction: TextInputAction.done,
              onEditingComplete: saveNewTask,
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a new task',
              ),
            ),
          ),
          GestureDetector(
            onTap: saveNewTask,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFFFFD54F),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
