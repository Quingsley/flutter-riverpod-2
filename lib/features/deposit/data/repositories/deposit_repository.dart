import 'package:bank_app/features/deposit/data/models/deposit_model.dart';
import 'package:bank_app/features/deposit/data/repositories/ideposit_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DepositRepository extends StateNotifier<double>
    implements IDepositRepository {
  final double? _amount;

  DepositRepository([this._amount = 0]) : super(0.0) {
    state = _amount!;
  }

  @override
  double get amountToDeposit => state;

  @override
  bool checkAmountToDeposit(DepositModel amount) {
    return amount.amount > 0;
  }

  @override
  void resetDepositRepository() {
    state = 0;
  }

  @override
  void setAmountToDepsosit(DepositModel amountToDeposit) {
    state = amountToDeposit.amount;
  }
}
