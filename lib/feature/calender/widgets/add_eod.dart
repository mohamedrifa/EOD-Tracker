import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './placeholder.dart';
import './TextEditor.dart';

class AddEodEntryForm extends StatefulWidget {
  final DateTime date;

  const AddEodEntryForm({super.key, required this.date});

  @override
  State<AddEodEntryForm> createState() => _AddEodEntryFormState();
}

class _AddEodEntryFormState extends State<AddEodEntryForm> {

  String status = "Yet to Start";

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          /// HEADER
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffF47C20),
                Color(0xffFF9A3C),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Add End of Day Entry",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('MMMM d, y').format(widget.date),
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),

                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 3,
            color: Colors.red,
          ),

          /// FORM BODY
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [

                /// Topic
                const Align(
                  alignment: Alignment.centerLeft,
                  child: RequiredLabel(text: "Topic"),
                ),

                const SizedBox(height: 8),

                Texteditor(hint: "Enter Task"),

                const SizedBox(height: 16),

                /// Time Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const RequiredLabel(text: "Expected Time"),
                          const SizedBox(height: 6),
                          Texteditor(hint: "Expected Time"),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const RequiredLabel(text: "Actual Time"),
                          const SizedBox(height: 6),
                          Texteditor(hint: "Actual Time"),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                /// Status
                const Align(
                  alignment: Alignment.centerLeft,
                  child: RequiredLabel(text: "Status")
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    statusButton("Yet to Start"),
                    statusButton("In Progress"),
                    statusButton("Completed"),
                  ],
                ),

                const SizedBox(height: 16),

                /// Description
                Texteditor(hint: "Describe What You Worked...", maxlines: 5,)
              ],
            ),
          ),

          /// BOTTOM BUTTONS
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              border: const Border(
                top: BorderSide(
                  color: Color.fromARGB(72, 158, 158, 158),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffF47C20),
                          Color(0xffFF9A3C),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Save Entry",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget statusButton(String value) {

    bool active = status == value;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: InkWell(
          onTap: () {
            setState(() {
              status = value;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: active ? const Color(0xffFF8C00) : Colors.white,
              border: Border.all(color: const Color(0xffFF8C00)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: active ? Colors.white : Colors.black87,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}