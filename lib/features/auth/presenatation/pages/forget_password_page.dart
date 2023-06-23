import 'package:bank_app/features/auth/presenatation/providers/auth_provider.dart';
import 'package:bank_app/features/auth/presenatation/widgets/error_container.dart';
import 'package:bank_app/features/auth/presenatation/widgets/flutter_bank_main_button.dart';
import 'package:bank_app/features/auth/presenatation/widgets/text_input.dart';
import 'package:bank_app/helpers/utils.dart';
import 'package:bank_app/shared/widgets/custom_app_bar.dart';
import 'package:bank_app/shared/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final isLoadingStateProvider = StateProvider<bool>((ref) => false);

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  const ForgetPasswordScreen({super.key});
  static const String route = '/forgot-password';

  @override
  ConsumerState<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  bool validateEmail(String email) {
    bool isValid = Utils.validateEmail(email) && email.isNotEmpty;
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    var authVM = ref.watch(authViewModelProvider);
    var isLoading = ref.watch(isLoadingStateProvider);
    Future.delayed(const Duration(seconds: 1), () {
      if (authVM.errorMessage.isNotEmpty) {
        if (ref.read(isLoadingStateProvider)) {
          ref.read(isLoadingStateProvider.notifier).state = false;
        }
      }
    });
    void submitHandler() {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Password Reset'),
          content: const Text(
              'On clicking Ok an email will be sent to the provide email with a link to reset your password.'),
          actions: [
            TextButton(
              onPressed: () async {
                ref.read(isLoadingStateProvider.notifier).state = true;
                bool isEmailSent = await authVM
                    .forgotPasswordHandler(emailController.value.text);
                ref.read(isLoadingStateProvider.notifier).state = false;
                emailController.clear();
                if (context.mounted) {
                  if (isEmailSent) {
                    GoRouter.of(context).pop();
                  }
                  Navigator.of(context).pop();
                }
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CANCEL'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password Reset',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  TextInputField(
                    controller: emailController,
                    icon: Icons.mail,
                    onChange: (value) {
                      //clear error message if any
                      if (authVM.errorMessage.isNotEmpty) {
                        authVM.clearErrorMessage();
                      }
                    },
                    onSubmitted: (val) {
                      if (validateEmail(val)) {
                        submitHandler();
                      }
                    },
                    hintText: 'Email',
                  ),
                  if (authVM.errorMessage.isNotEmpty)
                    const Expanded(
                      child: ErrorContainer(
                        message:
                            'The email Provided does not have an associated account with our services',
                      ),
                    ),
                  isLoading
                      ? const LoadingSpinner()
                      : FlutterBankMainButton(
                          label: 'Reset Password',
                          icon: Icons.mail,
                          enabled: validateEmail(emailController.text),
                          onTap: () {
                            submitHandler();
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
