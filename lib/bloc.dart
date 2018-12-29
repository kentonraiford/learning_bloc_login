import 'dart:async';
import 'validator.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators implements BaseBloc {

  //There are two items giving us inputs. Email and password textfield. We will need to create a stream controller for both.

  final _emailController = BehaviorSubject<String>(); //This needs to be a string type because the input data from the email textfield will be of String value.
  final _passwordController = BehaviorSubject<String>(); //BehaviorSubject lets us broadcast using rxdart

  //This is for the bloc to reach to whatever the user inputs into the text fields.
  //Whenever there's an input, the email will be changed.
  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;


  //We want output from the fields saying whether the text input is valid or not. We'll need to create a stream.
  //When the data is in the stream we can transform the data and check whether it's valid or not.
  //Email validator is our transformer from validator.dart.
  Stream<String> get emailStream => _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream => _passwordController.stream.transform(passwordValidator);

  //We need to use rxdart to check if both have the correct data we input from the sink.
  Stream<bool> get submitCheck => Observable.combineLatest2(emailStream, passwordStream, (e,p) => true); //when both email stream and password stream have data, it will return true.


  @override
  void dispose(){
    _emailController?.close(); //If the controller is not nil, then close it.
    _passwordController?.close();
  }
}

abstract class BaseBloc {
  void dispose(); // We need to ensure we're closing our controllers when we're done with them to prevent memory leaks.
}