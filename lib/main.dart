import 'package:employee_management_app/pages/employee_details_page.dart';
import 'package:employee_management_app/pages/employee_list_page.dart';
import 'package:employee_management_app/pages/new_employee_page.dart';
import 'package:employee_management_app/providers/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => EmployeeProvider()..getEmployees(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: EmployeeList.routeName,
      routes: {
        EmployeeList.routeName: (context) => const EmployeeList(),
        EmployeeDetails.routeName: (context) => const EmployeeDetails(),
        NewEmployeePage.routeName: (context) => const NewEmployeePage(),
      },
    );
  }
}
