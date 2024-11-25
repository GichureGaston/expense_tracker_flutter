class BudgetTracker {
  int? id;
  String? amount;
  String? name;
  String? createdAt;
  String? updatedAt;

  BudgetTracker(
      {this.id, this.amount, this.name, this.createdAt, this.updatedAt});

  BudgetTracker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
