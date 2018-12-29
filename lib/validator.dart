import 'dart:async';

mixin Validators {
  //We are making a stream transformer for the email Stream. We specify the type for email and sink as String.
  //We use this to handle the data
  var emailValidator = StreamTransformer<String, String>.fromHandlers(

      //We will get the string of email the user inputs.
      //Second is the sink where we can add the error.
      handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email); // Add it to the sink so we can have this data.
    } else {
      sink.addError('Email is invalid'); //It's invalid so we send an error.
    }
  });

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
  handleData: (password, sink) {
  if (password.length > 4) {
  sink.add(password);
  } else {
  sink.addError('Password length should be greater than 4 characters.');
  }
  });
}
