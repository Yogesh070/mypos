class OpenTicketModel {
  String? name;
  String? amount;
  DateTime? created;
  bool? isChecked;
  bool? ismerged;

  OpenTicketModel({
    this.isChecked,
    this.name,
    this.amount,
    this.created,
    this.ismerged,
  });
}
