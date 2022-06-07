import 'package:flutter/material.dart';
import 'package:ticketing_system/constraints.dart';
import 'package:ticketing_system/database/database_helper.dart';
import 'package:ticketing_system/roundButton.dart';
import 'package:ticketing_system/screen/AdminScreen/all_event_request.dart';
import 'package:ticketing_system/screen/CustomerScreen/all_events.dart';
import 'package:ticketing_system/screen/Organizer/create_event.dart';
import 'package:ticketing_system/screen/user_register.dart';

class LoginAsAdminOrOrganizer extends StatefulWidget {
  LoginAsAdminOrOrganizer({required this.category});

  String? category;

  static final String loginAsAdminOrOrganizerScreen =
      '/loginAsAdminOrOrganizerScreen';

  @override
  State<LoginAsAdminOrOrganizer> createState() =>
      _LoginAsAdminOrOrganizerState();
}

class _LoginAsAdminOrOrganizerState extends State<LoginAsAdminOrOrganizer> {
  String? email;
  String? password;
  var items = ['Admin', 'Organizer'];
  var anotherItem = ['Reguler Customer', 'VIP'];
  String? dropdownvalue;
  bool? is_authenticated = false;

  @override
  Widget build(BuildContext context) {


    void checkForAuthentication() async {}

    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.category!.toLowerCase() == 'adminororganizer' ?
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Log in',
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                email = value;
              },
              decoration: kInputDecorations.copyWith(hintText: 'Enter Email'),
            ),
            SizedBox(
              height: 8.0,
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
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
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
                  print(email);
                  int response = await DatabaseHelper.instance
                      .checkAuthentication(email!, password!, dropdownvalue!);
                  if (response > 0) {
                    print(response);
                    setState(() {
                      is_authenticated = true;
                    });
                  }
                  if (is_authenticated = true) {
                    print('Check is Authenticated: ' +
                        is_authenticated.toString());
                    if (dropdownvalue!.toLowerCase() == 'admin') {
                      // Navigate to Event Request page
                      Navigator.push(context, MaterialPageRoute<void>(
                        // Action 0 => update, Action 1 => save
                          builder: (BuildContext context) =>  AllEventRequest()
                      ),
                      );
                    } else {
                      Navigator.push(context, MaterialPageRoute<void>(
                        // Action 0 => update, Action 1 => save
                          builder: (BuildContext context) =>  CreateEvent(userId: response)
                      ),
                      );
                    }
                  }
                }
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  // Action 0 => update, Action 1 => save
                    builder: (BuildContext context) =>  RegisterUser(category: 'adminororganizer')
                ),
                );
              },
              child: new Text("No Account? Click to Register!"),
            )
          ],
        ),
      ) :
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Log in',
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                email = value;
              },
              decoration: kInputDecorations.copyWith(hintText: 'Enter Email'),
            ),
            SizedBox(
              height: 8.0,
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
              icon: const Icon(Icons.keyboard_arrow_down),

              items: anotherItem.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
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
                  print(email!);
                  print(password!);
                  print(dropdownvalue!);
                  int response = await DatabaseHelper.instance
                      .checkAuthentication(email!, password!, dropdownvalue!);
                  print(response);
                  if (response > 0) {
                    print(response);
                    setState(() {
                      is_authenticated = true;
                    });
                  }
                  if (is_authenticated = true) {
                    print('Check is Authenticated: ' +
                        is_authenticated.toString());
                    Navigator.push(context, MaterialPageRoute<void>(
                      // Action 0 => update, Action 1 => save
                        builder: (BuildContext context) =>  AllEvents(customer_id: response)
                    ),
                    );
                    // if (dropdownvalue!.toLowerCase() == 'admin') {
                    //   // Navigate to Event Request page
                    // } else {
                    //   // Navigate to Event Create page
                    // }
                  }
                }
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  // Action 0 => update, Action 1 => save
                    builder: (BuildContext context) =>  RegisterUser(category: 'customer')
                ),
                );
              },
              child: new Text("No Account? Click to Register!"),
            )
          ],
        ),
      )
    );
  }
}
