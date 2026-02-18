import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/index.dart';
import '../helpers/validators.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  String _userType = 'realtor';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Join CubiCasa',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextInputField(
                    label: 'First Name',
                    controller: _firstNameController,
                    validator: (value) => Validators.validateName(value),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextInputField(
                    label: 'Last Name',
                    controller: _lastNameController,
                    validator: (value) => Validators.validateName(value),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextInputField(
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => Validators.validateEmail(value),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  DropdownField<String>(
                    label: 'User Type',
                    value: _userType,
                    items: const [
                      DropdownMenuItem(value: 'realtor', child: Text('Real Estate Agent')),
                      DropdownMenuItem(value: 'insurance', child: Text('Insurance Agent')),
                      DropdownMenuItem(value: 'appraiser', child: Text('Appraiser')),
                    ],
                    onChanged: (value) {
                      setState(() => _userType = value ?? 'realtor');
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextInputField(
                    label: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) => Validators.validatePassword(value),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextInputField(
                    label: 'Confirm Password',
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator: (value) => Validators.validateConfirmPassword(
                      _passwordController.text,
                      value,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              label: 'Create Account',
              onPressed: _handleRegister,
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                TextButton_(
                  label: 'Login',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
