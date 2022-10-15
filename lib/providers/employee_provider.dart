import 'package:employee_management_app/models/employee_model.dart';
import 'package:flutter/material.dart';

class EmployeeProvider extends ChangeNotifier {
  List<EmployeeModel> employees = [];

  addEmployee(EmployeeModel employee) {
    employees.add(employee);
    notifyListeners();
  }
  getEmployees(){
    employees = employeeList;
    notifyListeners();
  }
  deleteEmployee(EmployeeModel employeeModel){
    employees.remove(employeeModel);
    notifyListeners();
  }
  updateFavorite(int index){
    employees[index].favourite= !employees[index].favourite;
    notifyListeners();
  }
}
