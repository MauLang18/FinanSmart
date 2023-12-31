class BudgetModel {
  int amount;
  final String note;

  addAmount(int amount) {
    this.amount = this.amount + amount;
  }

  BudgetModel(this.amount, this.note);
}
