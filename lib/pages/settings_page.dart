import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/storage_util.dart';
import '../utils/ui_util.dart';
import '../widgets/settings/text_editor.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool hidePassword = true, hideConfirmPassword = true;
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

  Future<void> updateUser() async {
    // if (passwordController.text != confirmPasswordController.text) {
    //   UiUtil.showSnack(context, "Passwords do not match");
    //   return;
    // }
    // setState(() => loading = true);
    // final id = await StorageUtil.getToken();
    // final success = await ApiService.updateUser(
    //   id: id!,
    //   name: nameController.text,
    //   email: emailController.text,
    //   password: passwordController.text.isEmpty
    //       ? null
    //       : passwordController.text,
    // );
    // setState(() => loading = false);
    // if (success) {
    //   UiUtil.showSnack(context, "Profile Updated");
    // } else {
    //   UiUtil.showSnack(context, "Update Failed");
    // }
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

                      TextEditor(
                        controller: nameController,
                        label: "Name",
                      ),

                      const SizedBox(height: 20),

                      TextEditor(
                        controller: emailController,
                        label: "Email",
                        enabled: false,
                      ),

                      const SizedBox(height: 20),

                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "New Password",
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Confirm Password",
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 30),

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
                          onPressed: loading ? null : updateUser,
                          child: Text(
                            loading ? "Loading..." : "Save Changes",
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 50,

                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xffF47C20),
                            ),
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
                      )
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