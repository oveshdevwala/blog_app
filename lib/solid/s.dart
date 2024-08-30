// Single Responsibility Principle -Sepreate the function According Usage.

// Wrong Aproach - It is Breaking the Rule

class UserManager {
  bool authenticateUser(String userName, String password) {
    return true;
  }

  String updateUserProfile(String userName, Map<String, dynamic> profileData) {
    return 'Profile Updated';
  }
}

// Right Aproach For Single Responsibility Principle
class AuthManager {
  bool authenticateUser(String userName, String password) {
    return true;
  }
}

class ProfileManager {
  String updateUserProfile(String userName, Map<String, dynamic> profileData) {
    return 'Profile Updated';
  }
}

