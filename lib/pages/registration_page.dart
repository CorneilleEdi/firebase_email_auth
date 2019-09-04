import 'package:email_auth/auth/auth_service.dart';
import 'package:email_auth/pages/widgets/common.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService auth = AuthService();

  // Scaffold key for showing snackbar
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Registration",
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Email registration with firebase',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            SizedBox(height: 50.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    //Hide keybord to show snackbar on error
                    FocusScope.of(context).requestFocus(FocusNode());

                    showLoading(context);
                    var user = await auth.createUserWithEmailAndPassword(
                        _emailController.text.trim(),
                        _passwordController.text.trim());
                    if (user != null) {
                      //If user is created, first remove until '/' and go to main
                      dismissLoading(context);

                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (route) => false);
                    } else {
                      dismissLoading(context);

                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: new Text('Login error, please try again')));
                    }
                  },
                ),
              ],
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              minWidth: double.infinity,
              height: 50,
              textColor: Colors.black87,
              child: Text(
                'Back to Login',
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
