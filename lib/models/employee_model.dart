class EmployeeModel {
  int? empId;
  String name;
  String dob;
  String mobileNumber;
  String emailAddress;
  String streetAddress;
  num salary;
  String image;
  String designation;
  String gender;
  bool favourite;

  EmployeeModel(
      {this.empId,
      required this.name,
      required this.dob,
      required this.mobileNumber,
      required this.emailAddress,
      required this.streetAddress,
      required this.salary,
      required this.image,
      required this.designation,
      required this.gender,
      this.favourite=false}
  );
}

final List<EmployeeModel> employeeList = [
  EmployeeModel(
      name: "addon",
      dob: "01/02/1999",
      mobileNumber: "0171478563",
      emailAddress: "asdf@gmail.com",
      streetAddress: "BDBL vaban",
      salary: 12000,
      image:
          "/data/user/0/com.example.employee_management_app/cache/5f9389e9-1904-4be5-aeda-2c9437e107e33429850771600893827.jpg",
      designation: "Tester",
      gender: "Male")
];

final designationList = <String>[
  "CEO",
  "Project manager",
  "Programmer",
  "Tester",
  "SQA",
  "Software Engineer"
];
