import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './placeholder.dart';
import './TextEditor.dart';
import '../../../models/eod_model.dart';

class AddEodEntryForm extends StatefulWidget {
  final DateTime date;
  final Eod? existingTask;
  const AddEodEntryForm({
    super.key,
    required this.date,
    this.existingTask,
  });
  @override
  State<AddEodEntryForm> createState() => _AddEodEntryFormState();
}

class _AddEodEntryFormState extends State<AddEodEntryForm> {

  String status = "Yet to Start";
  final topicController = TextEditingController();
  final expectedController = TextEditingController();
  final actualController = TextEditingController();
  final descController = TextEditingController();
  bool edit = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingTask != null) {
      edit = true;
      topicController.text = widget.existingTask!.topic ?? "";
      expectedController.text = widget.existingTask!.expectedTime ?? "";
      actualController.text = widget.existingTask!.actualTime ?? "";
      descController.text = widget.existingTask!.description ?? "";
      status = widget.existingTask!.status ?? "Yet to Start";
    }
  }

  Future<void> saveEod() async {
    setState(() {
      loading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("token");
    final url = widget.existingTask == null
        ? Uri.parse("https://eod-backend-ykjw.onrender.com/api/Eod")
        : Uri.parse("https://eod-backend-ykjw.onrender.com/api/Eod/${widget.existingTask!.id}");
    final method = widget.existingTask == null ? "POST" : "PUT";
    final body = jsonEncode({
      "topic": topicController.text,
      "userId": userId,
      "expectedTime": expectedController.text,
      "actualTime": actualController.text,
      "description": descController.text,
      "status": status,
      "createdAt": widget.date.toIso8601String(),
    });
    final response = await http.Request(method, url)
      ..headers['Content-Type'] = 'application/json'
      ..body = body;
    final streamed = await response.send();
    final res = await http.Response.fromStream(streamed);
    setState(() {
      loading = false;
    });
    if (res.statusCode == 200 || res.statusCode == 201) {
      Navigator.pop(context, true);
    } else {
      print(res.body);
    }
  }

  Future<void> deleteEod() async {
    if (widget.existingTask == null) return;
    setState(() {
      loading = true;
    });
    final url = Uri.parse(
      "https://eod-backend-ykjw.onrender.com/api/Eod/${widget.existingTask!.id}"
    );
    final res = await http.delete(url);
    setState(() {
      loading = false;
    });
    if (res.statusCode == 200 || res.statusCode == 204) {
      Navigator.pop(context, true);
    } else {
      print(res.body);
    }
  }

  Future<void> confirmDelete() async {
    final confirm = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// ICON
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xffF47C20).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Color(0xffF47C20),
                    size: 28,
                  ),
                ),

                const SizedBox(height: 16),

                /// TITLE
                const Text(
                  "Delete Task",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),

                const SizedBox(height: 8),

                /// DESCRIPTION
                const Text(
                  "Are you sure you want to delete this task?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                  ),
                ),

                const SizedBox(height: 20),

                /// BUTTONS
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffF47C20),
                              Color(0xffFF9A3C),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (confirm == true) {
      deleteEod();
    }
  }

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
                    Text(
                      edit ? "Edit End of Day Entry" : "Add End of Day Entry",
                      style: const TextStyle(
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

                Row(
                  children: [
                    if (edit)
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: confirmDelete, // 🔥 delete flow
                      ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
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

                Texteditor(hint: "Enter Task", controller: topicController),

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
                          Texteditor(hint: "Expected Time", controller: expectedController,),
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
                          Texteditor(hint: "Actual Time", controller: actualController,),
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
                Texteditor(hint: "Describe What You Worked...", maxlines: 5, controller: descController,)
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: !loading ? const [
                          Color(0xffF47C20),
                          Color(0xffFF9A3C),
                        ] : const [
                          Color.fromARGB(255, 243, 182, 135),
                          Color.fromARGB(255, 250, 194, 141),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
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
                      onPressed: () {loading ? null : saveEod();},
                      child: Text(
                        edit ? "Edit Entry" : "Save Entry",
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