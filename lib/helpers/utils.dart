class Utils {
  static bool validateEmail(String? value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$';

    RegExp regex = RegExp(pattern);

    return (regex.hasMatch(value!));
  }
}

enum Collection { accounts, user_accounts, user_expenses }
