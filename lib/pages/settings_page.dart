import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/storage_util.dart';
import '../utils/toast_util.dart';
import '../widgets/text_editor.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool hideOld = true;
  bool hideNew = true;
  bool hideConfirm = true;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    setState(() => loading = true);

    final id = await StorageUtil.getToken();
    if (id == null) {
      setState(() => loading = false);
      return;
    }

    final data = await ApiService.getUser(id);
    if (data != null) {
      nameController.text = data["name"] ?? "";
      emailController.text = data["email"] ?? "";
    }

    setState(() => loading = false);
  }

  Future<void> updatePassword() async {
    final oldPass = oldPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    // 🔴 Validation
    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      ToastUtil.showError(context, "All fields are required");
      return;
    }

    if (newPass != confirmPass) {
      ToastUtil.showError(context, "Passwords do not match");
      return;
    }

    setState(() => loading = true);

    final id = await StorageUtil.getToken();
    if (id == null) {
      setState(() => loading = false);
      return;
    }

    final success = await ApiService.updatePassword(
      id: id,
      oldPassword: oldPass,
      newPassword: newPass,
    );

    setState(() => loading = false);

    if (success) {
      ToastUtil.showSuccess(context, "Password updated successfully");

      // clear fields
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } else {
      ToastUtil.showError(context, "Password update failed");
    }
  }

  Future<void> logout() async {
    await StorageUtil.clear();
    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      "/login",
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 237, 215),

      appBar: AppBar(
        backgroundColor: const Color(0xffF47C20),
        title: const Text(
          "Settings",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),

              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(25),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      const Text(
                        "Profile Settings",
                        style: TextStyle(
                          fontSize: 26,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Color(0xffF47C20),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // 🔹 Name
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xffE4C9A8)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.person, color: Color(0xffF47C20)),
                            const SizedBox(width: 10),

                            // Name
                            Expanded(
                              child: Text(
                                nameController.text,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            const SizedBox(width: 10),

                            // Divider
                            Container(
                              height: 16,
                              width: 1,
                              color: Colors.grey.shade300,
                            ),

                            const SizedBox(width: 10),

                            // Email
                            Expanded(
                              child: Text(
                                emailController.text,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 🔹 Old Password
                      TextEditor(
                        controller: oldPasswordController,
                        label: "Old Password",
                        obscureText: hideOld,
                        isPassword: true,
                        hideText: hideOld,
                        onToggle: () {
                          setState(() => hideOld = !hideOld);
                        },
                      ),

                      const SizedBox(height: 20),

                      // 🔹 New Password
                      TextEditor(
                        controller: newPasswordController,
                        label: "New Password",
                        obscureText: hideNew,
                        isPassword: true,
                        hideText: hideNew,
                        onToggle: () {
                          setState(() => hideNew = !hideNew);
                        },
                      ),

                      const SizedBox(height: 20),

                      // 🔹 Confirm Password
                      TextEditor(
                        controller: confirmPasswordController,
                        label: "Confirm Password",
                        obscureText: hideConfirm,
                        isPassword: true,
                        hideText: hideConfirm,
                        onToggle: () {
                          setState(() => hideConfirm = !hideConfirm);
                        },
                      ),

                      const SizedBox(height: 30),

                      // 🔹 Save Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffF47C20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: loading ? null : updatePassword,
                          child: Text(
                            loading ? "Loading..." : "Update Password",
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 🔹 Logout
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xffF47C20)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: logout,
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color(0xffF47C20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}