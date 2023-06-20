import 'package:bank_app/features/withdraw/repositories/iwithdraw_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WithdrawRepository extends StateNotifier<double>
    implements IWithdrawRepository {
  final double? _amount;

  WithdrawRepository([this._amount = 0]) : super(0.0) {
    state = _amount!;
  }

  @override
  double get amountToWithdraw => state;

  @override
  bool checkAmountToWithDraw(double amount) {
    return amount > 0;
  }

  @override
  void resetWithDrawRepository() {
    state = 0;
  }

  @override
  void setAmountToWithdraw(double amountToWithDraw) {
    state = amountToWithDraw;
  }
}
