abstract class IWithdrawRepository {
  double get amountToWithdraw;
  bool checkAmountToWithDraw(double amount);
  void resetWithDrawRepository();
  void setAmountToWithdraw(double amount);
}
