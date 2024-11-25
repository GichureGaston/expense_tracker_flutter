class ExpenseTracker {
  int? id;
  String? amount;
  String? name;
  String? createdAt;
  String? updatedAt;

  ExpenseTracker({
    this.id,
    this.name,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  ExpenseTracker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}
