import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meuapp/controller/holiday_controller.dart';
import 'package:meuapp/view/menu.dart';

class HolidayScreen extends StatefulWidget {
  const HolidayScreen({super.key});

  @override
  State<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  final HolidayController controller = HolidayController();
  late Future<List<dynamic>> futureHolidays;
  final int year = DateTime.now().year;
  int? selectedMonth;

  @override
  void initState() {
    super.initState();
    futureHolidays = controller.getHolidays(year, month: selectedMonth);
  }

  String formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(date);
    } catch (e) {
      return dateString;
    }
  }

  void _onMonthChanged(int? newMonth) {
    setState(() {
      selectedMonth = newMonth;
      futureHolidays = controller.getHolidays(year, month: selectedMonth);
    });
  }

  final List<String> _monthsInPortuguese = [
    'Todos', 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: Center(
          child: Text(
            "Feriados Nacionais",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 7, 100, 49),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          DropdownButton<int?>(
            value: selectedMonth,
            items: List.generate(13, (index) {
              return DropdownMenuItem<int?>(
                value: index == 0 ? null : index,
                child: Text(_monthsInPortuguese[index]),
              );
            }),
            onChanged: _onMonthChanged,
            underline: Container(),
            dropdownColor: const Color.fromARGB(255, 8, 133, 64),
            iconEnabledColor: Colors.white,
            style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8.0),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: futureHolidays,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro ao carregar feriados: ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Nenhum feriado encontrado."));
                } else {
                  final holidays = snapshot.data!;
                  return ListView.builder(
                    itemCount: holidays.length,
                    itemBuilder: (context, index) {
                      final holiday = holidays[index];
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          leading: const Icon(Icons.calendar_today, color: Color.fromARGB(255, 7, 100, 49)),
                          title: Text(
                            holiday['name'] ?? "Nome não informado",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            formatDate(holiday['date'] ?? "Data não informada"),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(16.0),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
