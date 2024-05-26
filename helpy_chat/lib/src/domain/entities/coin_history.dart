part of 'entities.dart';

class CoinHistory extends Equatable {
  final int? id;
  final String? date;
  final String? transactionType;
  final String? transactionDetail;
  final String? subTitle;
  final String? description;
  final int? userId;
  final int? debit;
  final int? credit;

  const CoinHistory({
    this.id,
    this.date,
    this.transactionType,
    this.transactionDetail,
    this.subTitle,
    this.description,
    this.userId,
    this.debit,
    this.credit,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        userId,
        transactionType,
        transactionDetail,
        subTitle,
        description,
        debit,
        credit
      ];

  @override
  bool get stringify => true;
}
