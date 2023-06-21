import 'package:bank_app/features/auth/presenatation/providers/auth_provider.dart';
import 'package:bank_app/features/auth/presenatation/widgets/error_container.dart';
import 'package:bank_app/features/auth/presenatation/widgets/flutter_bank_main_button.dart';
import 'package:bank_app/features/auth/presenatation/widgets/text_input.dart';
import 'package:bank_app/shared/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bank_app/routes/app_routes.dart';
import 'package:bank_app/features/accounts/presentation/pages/accounts_page.dart';
import 'package:bank_app/helpers/utils.dart';

final isLoadingStateProvider = StateProvider<bool>((ref) => false);

class FlutterAccountRegistration extends ConsumerStatefulWidget {
  const FlutterAccountRegistration({super.key});
  static const String route = '/register';

  @override
  ConsumerState<FlutterAccountRegistration> createState() =>
      _FlutterAccountRegistrationState();
}

class _FlutterAccountRegistrationState
    extends ConsumerState<FlutterAccountRegistration> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    usernameController.clear();
    passwordController.clear();
    confirmpasswordController.clear();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
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
    bool validateFormFields() {
      return Utils.validateEmail(usernameController.value.text) &&
          usernameController.value.text.isNotEmpty &&
          passwordController.value.text.isNotEmpty &&
          confirmpasswordController.value.text.isNotEmpty &&
          (passwordController.value.text ==
              confirmpasswordController.value.text);
    }

    void submitHandler() async {
      String email = usernameController.value.text;
      String password = passwordController.value.text;
      ref.read(isLoadingStateProvider.notifier).state = true;
      var isAccountCreated = await authVM.signUp(email, password);
      if (isAccountCreated) {
        usernameController.clear();
        passwordController.clear();
        ref.read(isLoadingStateProvider.notifier).state = false;
        GoRouter.of(AppRoutes.mainNav.currentContext!).go(AccountsPage.route);
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Icon(
            Icons.savings,
            size: 40,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 40),
                              child: Text(
                                'Create New Account',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            TextInputField(
                              controller: usernameController,
                              icon: Icons.mail,
                              onChange: (value) {
                                //Clear error message if any
                                ref
                                    .read(authViewModelProvider)
                                    .clearErrorMessage();
                              },
                              hintText: 'Email',
                              onSubmitted: (_) {
                                passwordFocusNode.requestFocus();
                              },
                            ),
                            TextInputField(
                              focusNode: passwordFocusNode,
                              controller: passwordController,
                              icon: Icons.lock,
                              onChange: (value) {
                                ref
                                    .read(authViewModelProvider)
                                    .clearErrorMessage();
                              },
                              hintText: 'Password',
                              obscureText: true,
                              onSubmitted: (_) {
                                confirmPasswordFocusNode.requestFocus();
                              },
                            ),
                            TextInputField(
                              focusNode: confirmPasswordFocusNode,
                              controller: confirmpasswordController,
                              icon: Icons.lock,
                              onChange: (value) {
                                //Clear error message if any
                                ref
                                    .read(authViewModelProvider)
                                    .clearErrorMessage();
                              },
                              hintText: 'Confirm Password',
                              obscureText: true,
                              onSubmitted: (_) {
                                submitHandler();
                              },
                            ),
                            if (authVM.errorMessage.isNotEmpty)
                              ErrorContainer(
                                message: authVM.errorMessage,
                              ),
                          ],
                        ),
                      ),
                      !isLoading
                          ? FlutterBankMainButton(
                              label: 'Register',
                              enabled: validateFormFields(),
                              onTap: submitHandler,
                            )
                          : const LoadingSpinner()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
