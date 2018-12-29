import 'package:flutter/material.dart';
import 'package:learning_bloc_login/bloc.dart';
import 'package:learning_bloc_login/page_two.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  changeThePage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PageTwo()));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Bloc(); //Gives us the object of the Bloc class we created.

    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Pattern"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<String>( //Specify the types to get the inheritance and use its methods.
                stream: bloc.emailStream, //The stream we are checking is email Stream
                builder: (context, snapshot) => TextField(
                  onChanged: bloc.emailChanged, //Whenever there's a change in the email, it will inform the bloc email controller and add it to the sink.
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter email",
                      labelText: "Email",
                      errorText: snapshot.error),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<String>(
                stream: bloc.passwordStream,
                builder: (context, snapshot) => TextField(
                  onChanged: bloc.passwordChanged,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter password",
                      labelText: "Password",
                      errorText: snapshot.error),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<bool>(
                stream: bloc.submitCheck,
                builder: (context, snapshot) => RaisedButton(
                  color: Colors.tealAccent,
                  onPressed: snapshot.hasData
                      ? () => changeThePage(context)
                      : null,
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
