class User {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String district;
  final String streetAddress;
  final DateTime createdAt;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.district,
    required this.streetAddress,
    required this.createdAt,
  });
}

class MockDatabase {
  static List<User> _users = [
    User(
      id: '1',
      fullName: 'Sok Visal',
      email: 'sok@gmail.com',
      phone: '012345678',
      password: '123456',
      district: 'Khan Chamkarmon',
      streetAddress: 'Street 271',
      createdAt: DateTime.now().subtract(Duration(days: 30)),
    ),
    User(
      id: '2',
      fullName: 'Chan Dara',
      email: 'chan@gmail.com',
      phone: '098765432',
      password: 'password',
      district: 'Khan Daun Penh',
      streetAddress: 'Street 310',
      createdAt: DateTime.now().subtract(Duration(days: 15)),
    ),
    User(
      id: '3',
      fullName: 'Test User',
      email: 'test@test.com',
      phone: '123456789',
      password: 'test123',
      district: 'Khan Tuol Kouk',
      streetAddress: 'Street 123',
      createdAt: DateTime.now().subtract(Duration(days: 5)),
    ),
  ];

  // Login method
  static User? login(String emailOrPhone, String password) {
    try {
      return _users.firstWhere(
            (user) =>
        (user.email.toLowerCase() == emailOrPhone.toLowerCase() ||
            user.phone == emailOrPhone) &&
            user.password == password,
      );
    } catch (e) {
      return null; // User not found
    }
  }

  // Register method
  static bool register(User newUser) {
    // Check if user already exists
    bool userExists = _users.any(
          (user) => user.email.toLowerCase() == newUser.email.toLowerCase() ||
          user.phone == newUser.phone,
    );

    if (!userExists) {
      _users.add(newUser);
      return true;
    }
    return false; // User already exists
  }

  // Get user by ID
  static User? getUserById(String id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get all users (for admin purposes)
  static List<User> getAllUsers() {
    return _users;
  }

  // Update user
  static bool updateUser(String id, User updatedUser) {
    int index = _users.indexWhere((user) => user.id == id);
    if (index != -1) {
      _users[index] = updatedUser;
      return true;
    }
    return false;
  }

  // Delete user
  static bool deleteUser(String id) {
    int initialLength = _users.length;
    _users.removeWhere((user) => user.id == id);
    return _users.length < initialLength;
  }

  // Check if email exists
  static bool emailExists(String email) {
    return _users.any((user) => user.email.toLowerCase() == email.toLowerCase());
  }

  // Check if phone exists
  static bool phoneExists(String phone) {
    return _users.any((user) => user.phone == phone);
  }
}
