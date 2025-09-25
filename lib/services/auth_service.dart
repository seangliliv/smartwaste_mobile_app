import '../data/mock_data.dart';

class AuthService {
  static User? _currentUser;

  // Get current logged in user
  static User? get currentUser => _currentUser;

  // Login
  static Future<LoginResult> login(String emailOrPhone, String password) async {
    // Simulate API delay
    await Future.delayed(Duration(seconds: 1));

    if (emailOrPhone.isEmpty || password.isEmpty) {
      return LoginResult(success: false, message: 'Please fill all fields');
    }

    User? user = MockDatabase.login(emailOrPhone, password);

    if (user != null) {
      _currentUser = user;
      return LoginResult(success: true, message: 'Login successful', user: user);
    } else {
      return LoginResult(success: false, message: 'Invalid email/phone or password');
    }
  }

  // Register
  static Future<RegisterResult> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String district,
    required String streetAddress,
  }) async {
    // Simulate API delay
    await Future.delayed(Duration(seconds: 1));

    // Validation
    if (fullName.isEmpty || email.isEmpty || phone.isEmpty ||
        password.isEmpty || district.isEmpty || streetAddress.isEmpty) {
      return RegisterResult(success: false, message: 'Please fill all fields');
    }

    if (!email.contains('@')) {
      return RegisterResult(success: false, message: 'Please enter a valid email');
    }

    if (password.length < 6) {
      return RegisterResult(success: false, message: 'Password must be at least 6 characters');
    }

    if (MockDatabase.emailExists(email)) {
      return RegisterResult(success: false, message: 'Email already exists');
    }

    if (MockDatabase.phoneExists(phone)) {
      return RegisterResult(success: false, message: 'Phone number already exists');
    }

    // Create new user
    User newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
      district: district,
      streetAddress: streetAddress,
      createdAt: DateTime.now(),
    );

    bool success = MockDatabase.register(newUser);

    if (success) {
      return RegisterResult(success: true, message: 'Registration successful', user: newUser);
    } else {
      return RegisterResult(success: false, message: 'Registration failed');
    }
  }

  // Logout
  static void logout() {
    _currentUser = null;
  }

  // Check if user is logged in
  static bool get isLoggedIn => _currentUser != null;
}

class LoginResult {
  final bool success;
  final String message;
  final User? user;

  LoginResult({required this.success, required this.message, this.user});
}

class RegisterResult {
  final bool success;
  final String message;
  final User? user;

  RegisterResult({required this.success, required this.message, this.user});
}


