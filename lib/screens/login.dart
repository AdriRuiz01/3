import 'package:flutter/material.dart';
import 'package:t3_shopping_list/screens/products.dart';


class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();


}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _eMailInput(),
            _passwordInput(),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _eMailInput(){
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'User',
          hintText: 'Write your email address',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),),
        ),
        validator: (value){
          if(value == null || value.isEmpty){
            return 'Sorry, user can\'t be empty.';
          }
          return null;
        },
      ),
    );
  }

  Widget _passwordInput(){
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        obscureText: true,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          hintText: 'Write your password',
          labelText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),),
        ),
        validator: (value){
          if(value == null || value.isEmpty){
            return 'Sorry, password can not be empty';
          }
          return null;
        },
      ),
    );
  }

  Widget _loginButton(){
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        child: const Text('Login'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Trying to login ...')),
              );
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductsScreen()));
            }
        }
      ),
    );
  }
}