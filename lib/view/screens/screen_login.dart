import 'package:flutter/material.dart';
import '../../widget/login_form.dart';
class ViewLoginScreen extends StatelessWidget {
  ViewLoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF010F58),
              Color(0xFF0020A9),
              Color(0xFF0020A9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Hello\nSign In!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(child: LoginForm(formKey: _formKey)),
          ],
        ),
      ),
    );
  }
}
