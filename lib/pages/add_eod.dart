import 'package:flutter/material.dart';
import '../widgets/eod/confirm_delete_dialog.dart';
import '../widgets/eod/eod_footer.dart';
import '../widgets/eod/eod_form_body.dart';
import '../widgets/eod/eod_header.dart';
import '../models/eod_model.dart';
import '../services/api_service.dart';
import '../utils/storage_util.dart';
import '../utils/toast_util.dart';

class AddEodEntryForm extends StatefulWidget {
  final DateTime date;
  final Eod? existingTask;
  final VoidCallback refresh;
  const AddEodEntryForm({
    super.key,
    required this.date,
    required this.refresh,
    this.existingTask,
  });
  @override
  State<AddEodEntryForm> createState() => _AddEodEntryFormState();
}

class _AddEodEntryFormState extends State<AddEodEntryForm> {

  String status = "Yet to Start";
  String currentStatus = "";
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
  void changeStatus(String val){
    if(currentStatus == "") {
      currentStatus = widget.existingTask!.status ?? "Yet to Start";
    }
    if(currentStatus == "Yet to Start" && (val == "In Progress" || val == "Completed")){
      setState(() {
        status = val;
      });
    } else if(currentStatus == "In Progress" && val == "Completed"){
      setState(() {
        status = val;
      });
    } else if(currentStatus == val){
      setState(() {
        status = val;
      });
    } else {
      ToastUtil.showInfo(context, "Cannot Revert the Status Once Saved");
    }
  }

  Future<void> saveEod() async {
    setState(() {
      loading = true;
    });
    String? userId = await StorageUtil.getToken();
    if (userId == null) return;
    if(topicController.text == ""){
      ToastUtil.showInfo(context, "Task topic is required");
      setState(() {
        loading = false;
      });
      return;
    }
    if(expectedController.text == "") {
      ToastUtil.showInfo(context, "Expected Time is required");
      setState(() {
        loading = false;
      });
      return;
    }
    if(status != "Completed" && actualController.text != ""){
      ToastUtil.showInfo(context, "You cannot Enter Actual Time at the Moment.");
      setState(() {
        loading = false;
      });
      return;
    }
    if(status == "Completed" && actualController.text == ""){
      ToastUtil.showInfo(context, "Actual Time is required when Task is Completed");
      setState(() {
        loading = false;
      });
      return;
    }
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
      widget.refresh();
      ToastUtil.showSuccess(context, "Task Added Successfully");
      Navigator.pop(context, true);
    } else {
      print("Failed to save EOD");
      ToastUtil.showError(context, "Something went Wrong.");
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
      ToastUtil.showSuccess(context, "Task Deleted");
      Navigator.pop(context, true);
    } else {
      print("Delete failed");
      ToastUtil.showError(context, "Something went Wrong.");
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
            onStatusChange: (val) {changeStatus(val);},
          ),

          EodFooter(
            loading: loading,
            edit: edit,
            onClose: () => Navigator.pop(context),
            onSave: saveEod,
          ),
        ],
      )
    );
  }
}