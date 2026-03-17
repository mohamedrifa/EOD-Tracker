import 'package:flutter/material.dart';
import '../widgets/eod/confirm_delete_dialog.dart';
import '../widgets/eod/eod_footer.dart';
import '../widgets/eod/eod_form_body.dart';
import '../widgets/eod/eod_header.dart';
import '../models/eod_model.dart';
import '../services/api_service.dart';
import '../utils/storage_util.dart';

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
    String? userId = await StorageUtil.getToken();
    if (userId == null) return;
    final success = await ApiService.saveEod(
      id: widget.existingTask?.id,
      topic: topicController.text,
      userId: userId,
      expectedTime: expectedController.text,
      actualTime: actualController.text,
      description: descController.text,
      status: status,
      createdAt: widget.date,
    );
    setState(() {
      loading = false;
    });
    if (success) {
      Navigator.pop(context, true);
    } else {
      print("Failed to save EOD");
    }
  }

  Future<void> deleteEod() async {
    if (widget.existingTask?.id == null) return;
    setState(() {
      loading = true;
    });
    final success = await ApiService.deleteEod(widget.existingTask!.id!);
    setState(() {
      loading = false;
    });
    if (success) {
      Navigator.pop(context, true);
    } else {
      print("Delete failed");
    }
  }

  Future<void> confirmDelete() async {
    final confirm = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const ConfirmDeleteDialog(),
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

          EodHeader(
            edit: edit,
            date: widget.date,
            onClose: () => Navigator.pop(context),
            onDelete: confirmDelete,
          ),

          Container(height: 3, color: Colors.red),

          EodFormBody(
            topicController: topicController,
            expectedController: expectedController,
            actualController: actualController,
            descController: descController,
            status: status,
            onStatusChange: (val) {
              setState(() {
                status = val;
              });
            },
          ),

          EodFooter(
            loading: loading,
            edit: edit,
            onSave: saveEod,
          ),
        ],
      )
    );
  }
}