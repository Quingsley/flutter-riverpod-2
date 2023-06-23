import 'package:bank_app/features/tabs/presentation/viewmodels/tabs_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final selectedTabIndexProvider = StateProvider<int>((ref) => 0);

// final screensProvider = StateProvider<List<Widget>>((ref) => const [
//       AccountsPage(),
//       WithdrawScreen(),
//       DepositScreen(),
//       ExpensesScreen(),
//     ]);

final newAccountVMProvider =
    Provider<NewAccountViewModel>((ref) => NewAccountViewModel(ref));
