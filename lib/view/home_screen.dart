import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:meuapp/controller/course_controller.dart';
import 'package:meuapp/model/course_model.dart';
import 'package:meuapp/view/form_edit_course.dart';
import 'package:meuapp/view/form_new_course.dart';
import 'package:meuapp/view/menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<CourseEntity>> futureCourses;
  final CourseController controller = CourseController();

  @override
  void initState() {
    super.initState();
    futureCourses = controller.getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const FormNewCourse()))
            .then((_) {
              setState(() {
                futureCourses = controller.getCourses();
              });
            });
        },
      ),
      appBar: AppBar(
        title: const Text("Lista de Cursos"),
      ),
      body: FutureBuilder<List<CourseEntity>>(
        future: futureCourses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar cursos: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum curso encontrado."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final course = snapshot.data![index];
                return Card(
                  elevation: 5,
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormEditCourse(course: course),
                              ),
                            ).then((_) {
                              setState(() {
                                futureCourses = controller.getCourses();
                              });
                            });
                          },
                          icon: Icons.edit,
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.black,
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Confirmação"),
                                content: const Text("Deseja realmente excluir este curso?"),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancelar"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await controller.deleteCourse(course.id!);
                                      Navigator.pop(context);
                                      setState(() {
                                        futureCourses = controller.getCourses();
                                      });
                                    },
                                    child: const Text("Confirmar"),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(child: Text("CS")),
                      title: Text(course.name ?? "Não informado"),
                      subtitle: Text(course.description ?? "Não informado"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
