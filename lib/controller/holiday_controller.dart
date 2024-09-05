import 'package:meuapp/core/api_service.dart';

class HolidayController {
  final ApiService apiService = ApiService();

  Future<List<dynamic>> getHolidays(int year, {int? month}) async {
    try {
      final holidays = await apiService.fetchHolidays(year);
      if (month != null) {
        return holidays.where((holiday) {
          final holidayDate = DateTime.parse(holiday['date']);
          return holidayDate.month == month;
        }).toList();
      }
      return holidays;
    } catch (e) {
      print('Erro ao obter feriados: $e');
      return [];
    }
  }
}
