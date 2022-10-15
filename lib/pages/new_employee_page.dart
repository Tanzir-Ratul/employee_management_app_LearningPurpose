import 'dart:io';

import 'package:employee_management_app/providers/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helper_functoin.dart';
import '../models/employee_model.dart';

class NewEmployeePage extends StatefulWidget {
  static const routeName = "/new_employee";

  const NewEmployeePage({Key? key}) : super(key: key);

  @override
  State<NewEmployeePage> createState() => _NewEmployeePageState();
}

class _NewEmployeePageState extends State<NewEmployeePage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final salaryController = TextEditingController();
  String? dob;
  String? imagePath;
  ImageSource imageSource = ImageSource.camera;
  String genderRadioGroupValue = "Male";
  String? designation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
        actions: [
          IconButton(onPressed: _saveEmployee, icon: const Icon(Icons.done))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              keyboardType: TextInputType.name,
              controller: nameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                filled: true,
                labelText: "Name",
                fillColor: Colors.white70,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.phone,
              controller: mobileController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.call),
                filled: true,
                labelText: "Mobile",
                fillColor: Colors.white70,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                filled: true,
                labelText: "Email",
                fillColor: Colors.white70,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.text,
              controller: addressController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_city),
                filled: true,
                labelText: "Address",
                fillColor: Colors.white70,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: salaryController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.money),
                filled: true,
                labelText: "Salary",
                fillColor: Colors.white70,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButton<String>(
                isExpanded: true,
                value: designation,
                hint: const Text("Select Designation"),
                items: designationList
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e),
                        )))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    designation = value;
                  });
                }),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Select Gender",
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: "Male",
                        groupValue: genderRadioGroupValue,
                        onChanged: (value) {
                          setState(() {
                            genderRadioGroupValue = value!;
                          });
                        },
                      ),
                      const Text("Male"),
                      Radio<String>(
                        value: "Female",
                        groupValue: genderRadioGroupValue,
                        onChanged: (value) {
                          setState(() {
                            genderRadioGroupValue = value!;
                          });
                        },
                      ),
                      const Text("Female"),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: selectDate,
                    child: const Text("Select Date of Birth")),
                Chip(label: Text(dob == null ? "no date chosen" : dob!))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 10,
                  child: imagePath == null
                      ? Image.asset("images/person_placeholder.png",
                          height: 100, width: 100, fit: BoxFit.cover)
                      : Image.file(
                          File(imagePath!),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          imageSource = ImageSource.camera;
                          getImage();
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text("Capture")),
                    TextButton.icon(
                        onPressed: () {
                          imageSource = ImageSource.gallery;
                          getImage();
                        },
                        icon: const Icon(Icons.photo),
                        label: const Text("Gallery"))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    salaryController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void selectDate() async {
    setState(() {});
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920),
        lastDate: DateTime.now());
    if (dateTime != null) {
      setState(() {
        dob = DateFormat("dd/MM/yyyy").format(dateTime);
      });
    }
  }

  void getImage() async {
    final selectImage = await ImagePicker().pickImage(source: imageSource);
    if (selectImage != null) {
      setState(() {
        imagePath = selectImage.path;
        print(imagePath);
      });
    }
  }

  void _saveEmployee() {
    if (nameController.text.isEmpty) {
      showMessage(context, "Please provide your name");
      return;
    }
    /* if(designation==null){
      showMessage(context, "Please select your designation");return;
    }*/

    final employee = EmployeeModel(
        name: nameController.text,
        dob: dob!,
        designation: designation!,
        mobileNumber: mobileController.text,
        emailAddress: emailController.text,
        streetAddress: addressController.text,
        salary: num.parse(salaryController.text),
        image: imagePath!,
        gender: genderRadioGroupValue);
    //employeeList.add(employee);
    EmployeeProvider employeeProvider = Provider.of<EmployeeProvider>(context,listen: false);
    employeeProvider.addEmployee(employee);
    Navigator.pop(context);
  }
}
