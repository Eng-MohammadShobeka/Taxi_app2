class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    if (!value.contains('@')) return "Enter a valid email";
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  static String? validateNotEmpty(String? value, String field) {
    if (value == null || value.isEmpty) return "$field is required";
    return null;
  }
}
