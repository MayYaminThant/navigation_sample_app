part of 'entities.dart';

class FaqData extends Equatable{
  final int? faqRankOrder;
  final String? language;
  final String? appType;
  final String? question;
  final String? answer;
  final int? viewTotalCount;
  final bool? hidden;

  const FaqData({
    this.faqRankOrder,
    this.language,
    this.appType,
    this.question,
    this.answer,
    this.viewTotalCount,
    this.hidden,
  });

  @override
  List<Object?> get props => [faqRankOrder, language, appType, question, answer, viewTotalCount, hidden];

  @override
  bool get stringify => true;
}
