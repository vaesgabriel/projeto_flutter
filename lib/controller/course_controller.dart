import 'package:meuapp/model/course_model.dart';
import 'package:meuapp/model/course_repository.dart';

class CourseController{

  CourseRepository repository = CourseRepository();

  Future<List<CourseEntity>> getCourses() async {
    List<CourseEntity> list = [];
    list = await repository.getAll();
    return list;
  }
  postNewCourse(CourseEntity courseEntity) async {
    try {
      await repository.postNewCourse(courseEntity);
    } catch (e) {
      rethrow;
    }
  }
  deleteCourse(String id) async {
    try {
      await repository.deleteCourse(id);
    } catch (e) {
      rethrow;
    }
  }
}