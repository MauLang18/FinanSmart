class SavingModel {
  int amount;
  final String note;
  int goalAmount;

  addAmount(int amount) {
    this.amount = this.amount + amount;
  }

  SavingModel(this.amount, this.note, this.goalAmount);
}
