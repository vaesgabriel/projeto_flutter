import 'package:flutter/material.dart';
import 'package:meuapp/controller/course_controller.dart';
import 'package:meuapp/model/course_model.dart';

class FormNewCourse extends StatefulWidget {
  const FormNewCourse({super.key});

  @override
  State<FormNewCourse> createState() => _FormNewCourseState();
}

class _FormNewCourseState extends State<FormNewCourse> {
  final formKey = GlobalKey<FormState>();
  CourseController controller = CourseController();

  TextEditingController textNameController = TextEditingController();
  TextEditingController textDescriptionController = TextEditingController();
  TextEditingController textStartAtController = TextEditingController();

 postNewCourse() async {
    try {
      CourseEntity course = CourseEntity(
        name:textNameController.text,
        description:textDescriptionController.text,
        startAt:textStartAtController.text);
    await controller.postNewCourse(course);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Dados Salvos com Sucesso.")),
    );
    Navigator.pop(context);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$e")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text("Formulário de curso"),
    ),
    body: Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: textNameController,
            validator: (value){
              if(value == null || value.isEmpty){
                return "Campo Obrigatório";
              }
              return null;
            },
          ),
          TextFormField(
            controller: textDescriptionController,
            validator: (value){
              if(value == null || value.isEmpty){
                return "Campo Obrigatório";
              }
              return null;
            },
          ),
          TextFormField(
            controller: textStartAtController,
            validator: (value){
              if(value == null || value.isEmpty){
                return "Campo Obrigatório";
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()){
                //salvar os dados da api
                postNewCourse();
              }
            },
            child: Text("Salvar"))
        ],
      ),
    ),
    );
  }
}