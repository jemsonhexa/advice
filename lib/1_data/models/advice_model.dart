import 'package:advisor/2_domain/entities/advice_entity.dart';
import 'package:equatable/equatable.dart';

class AdviceModel extends AdviceEntity with EquatableMixin {
  AdviceModel({required super.advice, required super.id});

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    final slip = json['slip'] ?? {};
    print(slip);
    return AdviceModel(
      advice: slip['advice'] ?? 'No advice found',
      id: slip['id'] ?? 0,
    );
  }
}
