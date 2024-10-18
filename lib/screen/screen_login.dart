import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose(); // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your mobile number to get OTP',
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 24),
            _buildPhoneNumberField(),
            const SizedBox(height: 24),
            _buildGetOtpButton(context),
            const SizedBox(height: 16),
            _buildTermsAndPrivacyPolicy(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return SizedBox(
      height: 58,
      child: TextField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(width: 0.8, color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(width: 0.8, color: Colors.grey.shade400),
          ),
          prefixText: '+91  ',
          prefixStyle: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          hintText: 'Enter Phone Number',
          hintStyle: const TextStyle(
              color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildGetOtpButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: const Size(double.infinity, 52),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        onPressed: () {
          context.push('/otp');
        },
        child: const Text(
          "Get OTP",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _buildTermsAndPrivacyPolicy() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            height: 1.4,
            fontWeight: FontWeight.w400),
        children: [
          const TextSpan(text: 'By clicking, I accept the '),
          TextSpan(
            text: 'Terms of Service',
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (kDebugMode) {
                  print("Terms of Service tapped");
                }
              },
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (kDebugMode) {
                  print("Privacy Policy tapped");
                }
              },
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  OtpVerificationScreenState createState() => OtpVerificationScreenState();
}

class OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    _setupOtpControllers();
  }

  void _setupOtpControllers() {
    for (int i = 0; i < _otpControllers.length; i++) {
      _otpControllers[i].addListener(() {
        if (_otpControllers[i].text.length == 1 &&
            i < _otpControllers.length - 1) {
          FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verifying OTP sent to',
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('8888888888',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w800)),
                const SizedBox(width: 8),
                const Icon(Icons.border_color_rounded,
                    color: Colors.blue, size: 18),
              ],
            ),
            const SizedBox(height: 24),
            _buildOtpFields(),
            const SizedBox(height: 26),
            _buildVerifyOtpButton(context),
            const SizedBox(height: 12),
            _buildResendOtp(),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 70,
          child: TextField(
            controller: _otpControllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildVerifyOtpButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: const Size(double.infinity, 52),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        onPressed: () {
          context.go('/main');
        },
        child: const Text(
          "Verify OTP",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _buildResendOtp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            // Logic to resend OTP
          },
          child: const Text(
            'Didn\'t receive the OTP?',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
        ),
        const Text(
          '59 sec',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w800, color: Colors.blue),
        ),
      ],
    );
  }
}
