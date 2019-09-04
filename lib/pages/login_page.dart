import 'package:email_auth/auth/auth_service.dart';
import 'package:email_auth/pages/widgets/common.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService auth = AuthService();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    //Check auth on login page
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/main', arguments: user);
        }
      },
    );
  }

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
                  "Login",
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Email login with firebase',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            SizedBox(height: 50.0),
            TextField(
              keyboardType: TextInputType.emailAddress,
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
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    //Hide keybord to show snackbar on error
                    FocusScope.of(context).requestFocus(FocusNode());

                    showLoading(context);
                    var user = await auth.signInWithEmailPassword(
                        _emailController.text.trim(),
                        _passwordController.text.trim());
                    if (user != null) {
                      dismissLoading(context);
                      Navigator.pushReplacementNamed(context, '/main',
                          arguments: user);
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
                Navigator.pushNamed(context, '/registration');
              },
              minWidth: double.infinity,
              height: 50,
              textColor: Colors.black87,
              child: Text(
                'Don\'t have an account? Create ',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
