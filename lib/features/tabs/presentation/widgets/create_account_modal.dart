import 'package:bank_app/features/accounts/data/models/account_model.dart';
import 'package:bank_app/features/auth/presenatation/widgets/text_input.dart';
import 'package:bank_app/features/tabs/providers/tabs_provider.dart';
import 'package:bank_app/shared/widgets/action_header.dart';
import 'package:bank_app/shared/widgets/flutter_bank_main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountsStateProvider =
    StateProvider<List<String>>((ref) => ['savings', 'checking']);
final accountCurrentIndexProvider = StateProvider<int>((ref) => 0);

class CreateBankAccountContainer extends ConsumerStatefulWidget {
  const CreateBankAccountContainer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateBankAccountContainerState();
}

class _CreateBankAccountContainerState
    extends ConsumerState<CreateBankAccountContainer> {
  TextEditingController accountNumber = TextEditingController();
  FocusNode accountTypeFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    accountNumber.dispose();

    accountTypeFocusNode.dispose();
  }

  void _showSnackBar(BuildContext context, String message, [Color? color]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color ?? Theme.of(context).colorScheme.errorContainer,
        content: Text(
          message,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var selectedAccount = ref.watch(accountsStateProvider);
    var selectedIndex = ref.watch(accountCurrentIndexProvider);
    var newAccountVM = ref.watch(newAccountVMProvider);

    return Container(
      height: size.height * .45,
      width: size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AccountActionHeader(
            headerTitle: 'Create An Account With Us',
            icon: Icons.handshake,
          ),
          Expanded(
            child: Column(
              children: [
                TextInputField(
                  controller: accountNumber,
                  icon: Icons.manage_accounts,
                  onChange: (value) {},
                  hintText: 'Account Number',
                  onSubmitted: (val) {
                    accountTypeFocusNode.requestFocus();
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.wallet,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 20,
                        top: 11,
                        bottom: 11,
                        right: 15,
                      ),
                      // focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        focusColor: Theme.of(context).colorScheme.primary,
                        focusNode: accountTypeFocusNode,
                        value: selectedAccount[selectedIndex],
                        isDense: true,
                        hint: const Text('Select an Account Type'),
                        dropdownColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        onChanged: (newValue) {
                          ref.read(accountCurrentIndexProvider.notifier).state =
                              selectedIndex == 0 ? 1 : 0;
                          // selectedAccount[selectedIndex] = newValue!;
                        },
                        items: selectedAccount.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                FlutterBankMainButton(
                  label: 'Create Account',
                  onTap: () async {
                    if (accountNumber.value.text.isNotEmpty &&
                        selectedAccount[selectedIndex].isNotEmpty) {
                      bool isAccountCreated =
                          await newAccountVM.createNewAccount(Account(
                              type: selectedAccount[selectedIndex],
                              accountNumber: accountNumber.value.text));
                      if (isAccountCreated) {
                        if (context.mounted) {
                          Navigator.of(context).pop();
                          _showSnackBar(
                            context,
                            'Pull to Refresh the see the changes',
                            Colors.green[400],
                          );
                        }
                      } else {
                        if (context.mounted) {
                          _showSnackBar(context,
                              'Unable To Create Account , Can only have Either Checking or Savings Account');
                          Navigator.of(context).pop();
                        }
                      }
                    } else {
                      _showSnackBar(context, 'Please Fill in the fields');
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
