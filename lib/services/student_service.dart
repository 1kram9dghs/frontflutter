import 'dart:convert';
import 'package:client/models/student_model.dart';
import 'package:http/http.dart' as http;

// Helper to handle HTTP errors
void handleHttpError(http.Response response) {
  if (response.statusCode < 200 || response.statusCode >= 300) {
    print('HTTP Error: ${response.statusCode}, Body: ${response.body}');
    throw Exception('HTTP Error: ${response.statusCode}, Body: ${response.body}');
  }
}

Future<List<Student>> getAllStudents() async {
  final uri = Uri.parse('http://10.0.2.2:8055/api/v1/students');
  final response = await http.get(uri);
  handleHttpError(response);
  return (json.decode(response.body) as List)
      .map((student) => Student.fromJson(student))
      .toList();
}

Future<Student> getStudentById(String id) async {
  final uri = Uri.parse('http://10.0.2.2:8055/api/v1/students/$id');
  final response = await http.get(uri);
  handleHttpError(response);
  return Student.fromJson(json.decode(response.body));
}

Future<Student> createStudent(Student student) async {
  final uri = Uri.parse('http://10.0.2.2:8055/api/v1/students/create');
  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: json.encode(student.toJson()),
  );
  handleHttpError(response);
  return Student.fromJson(json.decode(response.body));
}

Future<Student> updateStudent(Student student) async {
  final uri = Uri.parse('http://10.0.2.2:8055/api/v1/students/${student.id}');
  final response = await http.put(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: json.encode(student.toJson()),
  );
  handleHttpError(response);
  return Student.fromJson(json.decode(response.body));
}

Future<void> deleteStudent(String id) async {
  final uri = Uri.parse('http://10.0.2.2:8055/api/v1/students/$id');
  final response = await http.delete(uri);
  handleHttpError(response);
}
