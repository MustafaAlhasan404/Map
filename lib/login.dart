import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  bool _savePassword = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleSavePassword(bool? value) {
    setState(() {
      _savePassword = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171738),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                _buildHeaderText('Login'),
                const SizedBox(height: 24),
                _buildInputField('Username', _usernameController),
                const SizedBox(height: 24),
                _buildPasswordInput(),
                const SizedBox(height: 24),
                _buildRememberMeCheckbox(),
                const SizedBox(height: 24),
                _buildLoginButton(),
                const SizedBox(height: 24),
                _buildSignupButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: GoogleFonts.sora(
        textStyle: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFF9067C6),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return _buildContainer(
      child: TextFormField(
        controller: controller,
        style: _inputTextStyle(),
        decoration: _inputDecoration(label, backgroundColor: Color(0xFFF7ECE1)),
      ),
    );
  }

  Widget _buildPasswordInput() {
    return _buildContainer(
      child: TextFormField(
        obscureText: _obscurePassword,
        controller: _passwordController,
        style: _inputTextStyle(),
        decoration: _inputDecoration('Password',
            backgroundColor: Color(0xFFF7ECE1),
            suffixIcon: _buildPasswordSuffixIcon()),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: _savePassword,
          onChanged: _toggleSavePassword,
          fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Color(0xFFF7ECE1);
              }
              return Color(0xFFF7ECE1);
            },
          ),
          checkColor: Color(0xFF35368E),
          activeColor: Color(0xFFF7ECE1),
        ),
        _buildCheckboxText('Remember me'),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // _performLogin(context);
        },
        child: Text(
          'Login',
          style: _buttonTextStyle(),
        ),
        style: _buttonStyle(),
      ),
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignupPage()),
          );
        },
        child: RichText(
          text: TextSpan(
            text: 'Don\'t have an account? ',
            style: GoogleFonts.sora(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            children: [
              TextSpan(
                text: 'Sign up',
                style: GoogleFonts.sora(
                  textStyle: TextStyle(
                    color: Color(0xFF8D86C9),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF7ECE1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }

  Widget _buildPasswordSuffixIcon() {
    return IconButton(
      icon: Icon(
        _obscurePassword ? Icons.visibility : Icons.visibility_off,
        color: Color(0xFF9067C6),
      ),
      onPressed: _togglePasswordVisibility,
    );
  }

  TextStyle _inputTextStyle() {
    return GoogleFonts.sora(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  InputDecoration _inputDecoration(String labelText,
      {Widget? suffixIcon, Color? backgroundColor}) {
    final borderColor = backgroundColor ?? Color(0xFFF7ECE1);

    return InputDecoration(
      labelText: labelText,
      labelStyle: GoogleFonts.sora(
        textStyle: TextStyle(
          color: Color(0xFF8D86C9),
          fontSize: 18,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      suffixIcon: suffixIcon,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: backgroundColor,
      filled: true,
    );
  }

  Widget _buildCheckboxText(String text) {
    return Text(
      text,
      style: GoogleFonts.sora(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  TextStyle _buttonTextStyle() {
    return GoogleFonts.sora(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      primary: Color(0xFF9067C6),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 32,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      minimumSize: Size(double.infinity, 48),
    );
  }
}
