import 'dart:io';

import 'package:employee_management_app/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class EmployeeDetails extends StatefulWidget {
  static const routeName = "/details";

  const EmployeeDetails({Key? key}) : super(key: key);

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  late EmployeeModel employee;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    employee = ModalRoute.of(context)?.settings.arguments as EmployeeModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.name),
      ),
      body: ListView(
        children: [
          Image.file(
            File(employee.image),
            width: double.maxFinite,
            height: 300,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(employee.mobileNumber),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: _callEmployee , icon: const Icon(Icons.call)),
                IconButton(onPressed: _smsEmployee, icon: const Icon(Icons.sms)),
              ],
            ),
          ),
          ListTile(
            title: Text(employee.emailAddress),
            trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.email)),
          ),
          ListTile(
            title: Text(employee.streetAddress),
            trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.map)),
          ),
          ListTile(
            title: Text(employee.designation),
            trailing: Text("BDT ${employee.salary}"),
          ),
        ],
      ),
    );
  }

  void _callEmployee() async{
    final url = Uri.parse("tel:${employee.mobileNumber})");
    if(await canLaunchUrl(url)){
      await launchUrl(url);
    }
    else{
      throw "Could not launch url";
    }
  }
  void _smsEmployee() async{
    final url = Uri.parse("sms:${employee.mobileNumber})");
    if(await canLaunchUrl(url)){
      await launchUrl(url);
    }
    else{
      throw "Could not launch url";
    }
  }
}
