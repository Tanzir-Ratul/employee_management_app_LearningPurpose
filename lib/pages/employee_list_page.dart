import 'dart:io';

import 'package:employee_management_app/models/employee_model.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee"),
      ),
      body: Consumer<EmployeeProvider>(
        builder:(context,provider,child) => ListView.builder(
          itemCount: provider.employees.length,
          itemBuilder:(context,index){
            final emp = provider.employees[index];
            return ListTile(
              onTap: () => Navigator.pushNamed(context, EmployeeDetails.routeName,
                  arguments: emp),
              leading: CircleAvatar(
                backgroundImage: FileImage(File(emp.image)),
              ),
              title: Text(emp.name),
              subtitle: Text(
                emp.designation,
              ),
              trailing: IconButton(onPressed: (){
                  provider.updateFavorite(index);
              },
              icon: Icon(emp.favourite?Icons.favorite:Icons.favorite_border),),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewEmployeePage.routeName);//.then((value) => setState((){}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }




}
