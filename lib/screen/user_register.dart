import 'package:flutter/material.dart';
import 'package:ticketing_system/constraints.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/model/customer_model.dart';
import 'package:ticketing_system/model/user_model.dart';
import 'package:ticketing_system/roundButton.dart';

class RegisterUser extends StatefulWidget {

  RegisterUser({required this.category});

  static final String id = '/registerUser';
  String? category;
  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  String? roll;
  // Admin or Organizer
  String? name;

  String? phone;

  String? email;

  String? password;

  String? user_id;

  String? dropdownvalue;
  int? id;

  var items = ['Admin', 'Organizer'];
  var anotherItem = ['Reguler Customer', 'VIP'];
  bool registerd = false;
  void registerUser() async {
    User user =
        User(name: name, phone: phone, email: email, password: password);
    id = await DatabaseHelper.instance.insertUser(user, dropdownvalue!);
    if (id! > 0) {
      setState(() {
        registerd = true;
      });
    }
    // user_id = id.toString();
  }
  void registerCustomer() async {
    Customer customer =
    Customer(name: name, phone: phone, email: email, password: password);
    id = await DatabaseHelper.instance.insertCustomer(customer, dropdownvalue!);
    print(id);
    if (id! > 0) {
      setState(() {
        registerd = true;
      });
    }
    // user_id = id.toString();
  }

  @override
  Widget build(BuildContext context) {
    return widget.category!.toLowerCase() == 'customer' ?
    Scaffold(
      appBar: AppBar(title: Text('Create Account'),),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Register',
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  name = value;
                },
                decoration: kInputDecorations.copyWith(hintText: 'Enter Name'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  email = value;
                },
                decoration: kInputDecorations.copyWith(hintText: 'Enter Email'),
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  phone = value;
                },
                decoration: kInputDecorations.copyWith(hintText: 'Enter phone'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration:
                kInputDecorations.copyWith(hintText: 'Enter Password'),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                // Initial Value
                value: dropdownvalue,
                hint: Text('Choose a Category'),

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: widget.category!.toLowerCase() == 'adminororganizer' ?
                items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList() :
                anotherItem.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),

                // After selecting the desired option,it will
                // change button value to selected value
                onSaved: (String? value) {
                  setState(() {
                    dropdownvalue = value;
                    print(dropdownvalue);
                  });
                },
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    print(dropdownvalue);
                  });
                },
              ),
              RoundedButton(
                  title: 'Log In',
                  color: Colors.lightBlue,
                  onPress: () async {
                    registerCustomer();
                    if (registerd = true) {
                    }
                  }),
            ]),
      ),
    ) :
    Scaffold(
      appBar: AppBar(title: Text('Create Account'),),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Register',
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  name = value;
                },
                decoration: kInputDecorations.copyWith(hintText: 'Enter Name'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  email = value;
                },
                decoration: kInputDecorations.copyWith(hintText: 'Enter Email'),
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  phone = value;
                },
                decoration: kInputDecorations.copyWith(hintText: 'Enter phone'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration:
                kInputDecorations.copyWith(hintText: 'Enter Password'),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                // Initial Value
                value: dropdownvalue,
                hint: Text('Choose a Category'),

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: widget.category!.toLowerCase() == 'adminororganizer' ?
                items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList() :
                anotherItem.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),

                // After selecting the desired option,it will
                // change button value to selected value
                onSaved: (String? value) {
                  setState(() {
                    dropdownvalue = value;
                    print(dropdownvalue);
                  });
                },
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    print(dropdownvalue);
                  });
                },
              ),
              RoundedButton(
                  title: 'Log In',
                  color: Colors.lightBlue,
                  onPress: () async {
                    registerUser();
                    if (registerd = true) {
                      if (dropdownvalue!.toLowerCase() == 'admin') {
                        // Navigate to Event Request page
                      } else {
                        // Navigate to Event Create page
                      }
                    }
                  }),
            ]),
      ),
    );

  }
}
