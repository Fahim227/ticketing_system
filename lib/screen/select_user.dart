import 'package:flutter/material.dart';
import 'package:ticketing_system/roundButton.dart';
import 'package:ticketing_system/screen/Organizer/login_page.dart';


class SelectUserType extends StatelessWidget {
  const SelectUserType({Key? key}) : super(key: key);

  static final String id = '/selectUserScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SelectUserType')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Use App as'),
            SizedBox(height: 40,),
            RoundedButton(
                title: 'Customer',
                color: Colors.lightBlue,
                onPress: () async {
                  Navigator.push(context, MaterialPageRoute<void>(
                    // Action 0 => update, Action 1 => save
                      builder: (BuildContext context) =>  LoginAsAdminOrOrganizer(category: 'customer')
                  ),
                  );
                } ),
            SizedBox(height: 20,),
            RoundedButton(
                title: 'Admin / Organizer',
                color: Colors.lightBlue,
                onPress: () async {
                    Navigator.push(context, MaterialPageRoute<void>(
                        // Action 0 => update, Action 1 => save
                        builder: (BuildContext context) =>  LoginAsAdminOrOrganizer(category: 'adminOrorganizer')
                      ),
                    );
                } )
          ],
        ),
      ),
    );
  }
}
