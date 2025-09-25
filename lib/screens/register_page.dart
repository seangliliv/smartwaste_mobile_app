import 'package:flutter/material.dart';
import '../utils/app_color.dart';
import '../utils/constants.dart';
import '../widgets/logo_widget.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  String _selectedDistrict = AppConstants.districts.first;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _streetAddressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      // Implement registration logic
      print('Registration attempted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: LogoWidget()),
              SizedBox(height: 40),
              _buildFormFields(),
              SizedBox(height: 30),
              _buildCreateAccountButton(),
              SizedBox(height: 20),
              _buildLoginLink(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back, color: AppColors.black),
      ),
      title: Text(
        'Create Account',
        style: TextStyle(
          color: AppColors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildTextField(
          label: 'Full Name',
          hint: 'Enter your full name',
          controller: _fullNameController,
          validator: (value) => value?.isEmpty ?? true ? 'Please enter your full name' : null,
        ),
        SizedBox(height: 20),
        _buildTextField(
          label: 'Phone Number',
          hint: 'Enter phone number',
          controller: _phoneController,
          validator: (value) => value?.isEmpty ?? true ? 'Please enter your phone number' : null,
        ),
        SizedBox(height: 20),
        _buildTextField(
          label: 'Email Address',
          hint: 'Enter email address',
          controller: _emailController,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Please enter your email';
            if (!value!.contains('@')) return 'Please enter a valid email';
            return null;
          },
        ),
        SizedBox(height: 20),
        _buildAddressSection(),
        SizedBox(height: 20),
        _buildPasswordField(),
        SizedBox(height: 20),
        _buildConfirmPasswordField(),
        SizedBox(height: 20),
        _buildTermsCheckbox(),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: _inputDecoration(hint),
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Home Address',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        _buildDistrictDropdown(),
        SizedBox(height: 12),
        TextFormField(
          controller: _streetAddressController,
          decoration: _inputDecoration('Street address'),
          validator: (value) => value?.isEmpty ?? true ? 'Please enter your street address' : null,
        ),
      ],
    );
  }

  Widget _buildDistrictDropdown() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: _selectedDistrict,
        isExpanded: true,
        underline: SizedBox(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedDistrict = newValue!;
          });
        },
        items: AppConstants.districts.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                value,
                style: TextStyle(
                  color: value == AppConstants.districts.first
                      ? AppColors.grey400
                      : Colors.black87,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Please enter a password';
            if (value!.length < 6) return 'Password must be at least 6 characters';
            return null;
          },
          decoration: _inputDecoration('Create password').copyWith(
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm Password',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Please confirm your password';
            if (value != _passwordController.text) return 'Passwords do not match';
            return null;
          },
          decoration: _inputDecoration('Confirm password').copyWith(
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
              icon: Icon(
                _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _agreeToTerms,
          onChanged: (bool? value) {
            setState(() {
              _agreeToTerms = value!;
            });
          },
          activeColor: AppColors.primary,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 12),
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black87, fontSize: 14),
                children: [
                  TextSpan(text: 'I agree to the '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateAccountButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _agreeToTerms ? _handleRegister : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Create Account',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account? ',
            style: TextStyle(color: AppColors.grey600),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Log In',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: AppColors.grey400),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.grey300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.grey300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }
}