import 'dart:io';

import 'package:employee_management_app/providers/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'employee_details_page.dart';
import 'new_employee_page.dart';

class EmployeeList extends StatefulWidget {
  static const routeName = "/";

  const EmployeeList({Key? key}) : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  Future<bool?> deleteConfirmation(DismissDirection direction) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Delete"),
              content: const Text("Are you sure ?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("Cancel")),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text("Yes")),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee"),
      ),
      body: Consumer<EmployeeProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.employees.length,
          itemBuilder: (context, index) {
            final emp = provider.employees[index];
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              confirmDismiss: deleteConfirmation,
              onDismissed: (_){
                provider.deleteEmployee(emp);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              child: ListTile(
                onTap: () => Navigator.pushNamed(
                    context, EmployeeDetails.routeName,
                    arguments: emp),
                leading: CircleAvatar(
                  backgroundImage: FileImage(File(emp.image)),
                ),
                title: Text(emp.name),
                subtitle: Text(
                  emp.designation,
                ),
                trailing: IconButton(
                  onPressed: () {
                    provider.updateFavorite(index);
                  },
                  icon: Icon(
                      emp.favourite ? Icons.favorite : Icons.favorite_border),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context,
              NewEmployeePage.routeName); //.then((value) => setState((){}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
