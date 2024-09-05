import 'package:flutter/material.dart';
import 'package:meuapp/controller/course_controller.dart';
import 'package:meuapp/model/course_model.dart';

class FormEditCourse extends StatefulWidget {
  final CourseEntity course;

  const FormEditCourse({required this.course, super.key});

  @override
  State<FormEditCourse> createState() => _FormEditCourseState();
}

class _FormEditCourseState extends State<FormEditCourse> {
  final formKey = GlobalKey<FormState>();
  final CourseController controller = CourseController();

  late TextEditingController textNameController;
  late TextEditingController textDescriptionController;

  @override
  void initState() {
    super.initState();
    textNameController = TextEditingController(text: widget.course.name ?? '');
    textDescriptionController = TextEditingController(text: widget.course.description ?? '');
  }

  @override
  void dispose() {
    textNameController.dispose();
    textDescriptionController.dispose();
    super.dispose();
  }

  Future<void> updateCourse() async {
    if (formKey.currentState!.validate()) {
      try {
        final updatedCourse = CourseEntity(
          id: widget.course.id,
          name: textNameController.text,
          description: textDescriptionController.text,
          startAt: widget.course.startAt,
        );
        await controller.updateCourse(updatedCourse);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Curso atualizado com sucesso.")),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao atualizar curso: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Curso"),
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
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: updateCourse,
                child: const Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
