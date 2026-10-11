import 'package:flutter/material.dart';
import 'package:movieapp/ui/colors.dart';
import 'package:movieapp/ui/reuse_button.dart';
import 'package:movieapp/ui/reuse_social_button.dart';
import 'package:movieapp/ui/reuse_textfield.dart';
import 'package:movieapp/ui/typography.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Login here',
                  style: lBold.copyWith(color: white),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Welcome back you've been missed!",
                  textAlign: TextAlign.center,
                  style: mSemiBold.copyWith(color: white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 36),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: ReuseTextfieldAuth(
                  controller: _usernameController,
                  labelText: 'Email atau Username',
                  hintText: 'Email atau Username',
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: ReuseTextfieldAuth(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Password',
                  obscureText: _isObscure,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(bottom: 24),
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fitur sedang dalam pengerjaan'),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: sBold.copyWith(color: blue),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: const ReuseButtonAuth(
                  isLogin: true,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 36),
                child: const ReuseButtonAuth(
                  isLogin: false,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Or continue with',
                  style: sBold.copyWith(color: blue),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReuseSocialButton(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur sedang dalam pengerjaan'),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.g_mobiledata,
                      color: white,
                      size: 34,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ReuseSocialButton(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur sedang dalam pengerjaan'),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.facebook,
                      color: white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ReuseSocialButton(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur sedang dalam pengerjaan'),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.apple,
                      color: white,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
