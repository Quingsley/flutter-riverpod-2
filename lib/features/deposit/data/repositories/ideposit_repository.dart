import 'package:bank_app/features/deposit/data/models/deposit_model.dart';

abstract class IDepositRepository {
  double get amountToDeposit;
  void setAmountToDepsosit(DepositModel amount);
  void resetDepositRepository();
  bool checkAmountToDeposit(DepositModel amount);
}
