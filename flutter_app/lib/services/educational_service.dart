import 'package:hive/hive.dart';

class EducationalService {
  static final EducationalService _instance = EducationalService._();

  factory EducationalService() => _instance;

  EducationalService._();

  Box<dynamic>? _box;
}
