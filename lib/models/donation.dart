class Donation {
  final int id;
  final int mosqueId;
  final double amount;
  final String createdAt;

  Donation({
    required this.id,
    required this.mosqueId,
    required this.amount,
    required this.createdAt,
  });

  factory Donation.fromMap(Map<String, dynamic> map) {
    return Donation(
      id: map['id'] as int,
      mosqueId: map['mosque_id'] as int,
      amount: (map['amount'] as num).toDouble(),
      createdAt: map['created_at'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mosque_id': mosqueId,
      'amount': amount,
      'created_at': createdAt,
    };
  }
}
