import 'package:bank_app/features/deposit/data/models/deposit_model.dart';
import 'package:bank_app/features/deposit/data/repositories/ideposit_repository.dart';

class MockDepositRepository implements IDepositRepository {
  @override
  double amountToDeposit = 0;
  @override
  bool checkAmountToDeposit(DepositModel amount) {
    return amountToDeposit > 0;
  }

  @override
  void resetDepositRepository() {
    amountToDeposit = 0;
  }

  @override
  void setAmountToDepsosit(DepositModel amount) {
    amountToDeposit = amount.amount;
  }
}
