import 'package:bank_app/features/auth/presenatation/pages/account_registration.dart';
import 'package:bank_app/features/auth/presenatation/pages/forget_password_page.dart';
import 'package:bank_app/features/auth/presenatation/widgets/error_container.dart';
import 'package:bank_app/features/auth/presenatation/widgets/text_input.dart';
import 'package:bank_app/features/landing/presentation/pages/landing_page.dart';
import 'package:bank_app/features/auth/presenatation/providers/auth_provider.dart';
import 'package:bank_app/features/auth/presenatation/widgets/flutter_bank_main_button.dart';
import 'package:bank_app/helpers/utils.dart';
import 'package:bank_app/routes/app_routes.dart';
import 'package:bank_app/shared/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final isLoadingStateProvider = StateProvider<bool>((ref) => false);

class FlutterBankLogin extends ConsumerStatefulWidget {
  const FlutterBankLogin({super.key});

  static const String route = '/login';

  @override
  ConsumerState<FlutterBankLogin> createState() => _FlutterBankLoginState();
}

class _FlutterBankLoginState extends ConsumerState<FlutterBankLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

  bool valideEmailAndPassword() {
    return usernameController.value.text.isNotEmpty &&
        passwordController.value.text.isNotEmpty &&
        Utils.validateEmail(usernameController.value.text);
  }

  void submitHandler() async {
    String userName = usernameController.value.text;
    String password = passwordController.value.text;

    ref.read(isLoadingStateProvider.notifier).state = true;

    bool isLoggedIn =
        await ref.watch(authViewModelProvider).signIn(userName, password);
    if (isLoggedIn) {
      usernameController.clear();
      passwordController.clear();
      ref.read(isLoadingStateProvider.notifier).state = false;
      GoRouter.of(AppRoutes.mainNav.currentContext!).go(LandingPage.route);
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
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
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) =>
              SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 7,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              100,
                            ),
                          ),
                        ),
                        child: Icon(
                          Icons.savings,
                          color: Theme.of(context).colorScheme.primary,
                          size: 45,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Welcome to',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Akiba\nSavings Bank',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 30,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Sign Into Your Bank Account',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextInputField(
                                controller: usernameController,
                                icon: Icons.mail,
                                onChange: (value) {
                                  //clear error message if any
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
                                  //clear error message if any
                                  ref
                                      .read(authViewModelProvider)
                                      .clearErrorMessage();
                                },
                                hintText: 'Password',
                                obscureText: true,
                                onSubmitted: (_) {
                                  submitHandler();
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  GoRouter.of(AppRoutes.mainNav.currentContext!)
                                      .push(ForgetPasswordScreen.route);
                                },
                                child: Text(
                                  'Forgot Password',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              if (authVM.errorMessage.isNotEmpty)
                                ErrorContainer(
                                  message: authVM.errorMessage,
                                ),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                      !isLoading
                          ? FlutterBankMainButton(
                              label: 'Sign In',
                              enabled: valideEmailAndPassword(),
                              onTap: () {
                                submitHandler();
                              },
                            )
                          : const LoadingSpinner(),
                      const SizedBox(
                        height: 10,
                      ),
                      FlutterBankMainButton(
                          label: 'Register',
                          icon: Icons.account_circle,
                          onTap: () {
                            ref.read(authViewModelProvider).clearErrorMessage();
                            GoRouter.of(AppRoutes.mainNav.currentContext!)
                                .push(FlutterAccountRegistration.route);
                          }),
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
