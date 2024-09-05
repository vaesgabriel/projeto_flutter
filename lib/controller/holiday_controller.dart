import 'package:meuapp/core/api_service.dart';

class HolidayController {
  final ApiService apiService = ApiService();

  Future<List<dynamic>> getHolidays(int year) async {
    try {
      return await apiService.fetchHolidays(year);
    } catch (e) {
      print('Erro ao obter feriados: $e');
      return []; // Retorna uma lista vazia em caso de erro
    }
  }
}
