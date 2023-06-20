class Utils {
  static bool validateEmail(String? value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$';

    RegExp regex = RegExp(pattern);
    print(regex.hasMatch(value!));
    return (regex.hasMatch(value));
  }
}

enum Collcetion { accounts, user_accounts }
