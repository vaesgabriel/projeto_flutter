import 'package:flutter/material.dart';
import 'package:meuapp/controller/course_controller.dart';
import 'package:meuapp/model/course_model.dart';

class FormNewCourse extends StatefulWidget {
  const FormNewCourse({super.key});

  @override
  State<FormNewCourse> createState() => _FormNewCourseState();
}

class _FormNewCourseState extends State<FormNewCourse> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CourseController controller = CourseController();

  final TextEditingController textNameController = TextEditingController();
  final TextEditingController textDescriptionController = TextEditingController();
  final TextEditingController textStartAtController = TextEditingController();

  Future<void> postNewCourse() async {
    if (formKey.currentState!.validate()) {
      try {
        final dateStr = textStartAtController.text;
        final date = DateTime.tryParse(dateStr);

        final course = CourseEntity(
          name: textNameController.text,
          description: textDescriptionController.text,
          startAt: date,
        );
        await controller.postNewCourse(course);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Dados salvos com sucesso.")),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao salvar dados: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de Curso"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: textNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Nome do Curso'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: textDescriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Descrição do Curso'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: textStartAtController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }
                  if (DateTime.tryParse(value) == null) {
                    return "Data inválida";
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Data de Início'),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: postNewCourse,
                child: const Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
