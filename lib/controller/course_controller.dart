import 'package:meuapp/model/course_model.dart';
import 'package:meuapp/model/course_repository.dart';

class CourseController {
  final CourseRepository repository = CourseRepository();

  Future<List<CourseEntity>> getCourses() async {
    try {
      return await repository.getAll();
    } catch (e) {
      // Adicione um log ou tratamento mais robusto para erros aqui
      print('Erro ao obter cursos: $e');
      return []; // Retorna uma lista vazia em caso de erro
    }
  }

  Future<void> postNewCourse(CourseEntity courseEntity) async {
    try {
      await repository.postNewCourse(courseEntity);
    } catch (e) {
      // Adicione um log ou tratamento mais robusto para erros aqui
      print('Erro ao postar novo curso: $e');
      rethrow;
    }
  }

  Future<void> deleteCourse(String id) async {
    try {
      await repository.deleteCourse(id);
    } catch (e) {
      // Adicione um log ou tratamento mais robusto para erros aqui
      print('Erro ao excluir curso: $e');
      rethrow;
    }
  }

  Future<void> updateCourse(CourseEntity courseEntity) async {
    try {
      await repository.updateCourse(courseEntity);
    } catch (e) {
      // Adicione um log ou tratamento mais robusto para erros aqui
      print('Erro ao atualizar curso: $e');
      rethrow;
    }
  }
}
