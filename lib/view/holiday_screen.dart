import 'package:flutter/material.dart';
import 'package:meuapp/view/menu.dart';
import 'package:meuapp/controller/holiday_controller.dart'; // Ajuste o caminho se necessário

class HolidayScreen extends StatefulWidget {
  const HolidayScreen({super.key});

  @override
  State<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  final HolidayController controller = HolidayController();
  late Future<List<dynamic>> futureHolidays;
  final int year = DateTime.now().year; // Ano atual

  @override
  void initState() {
    super.initState();
    futureHolidays = controller.getHolidays(year);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feriados Nacionais"),
      ),
      drawer: const MenuDrawer(),
      body: FutureBuilder<List<dynamic>>(
        future: futureHolidays,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar feriados: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum feriado encontrado."));
          } else {
            final holidays = snapshot.data!;
            return ListView.builder(
              itemCount: holidays.length,
              itemBuilder: (context, index) {
                final holiday = holidays[index];
                return ListTile(
                  title: Text(holiday['name'] ?? "Nome não informado"),
                  subtitle: Text(holiday['date'] ?? "Data não informada"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
