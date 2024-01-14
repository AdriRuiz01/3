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
    String user = 'Adrian@gmail.com';
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
          } else if(!value.contains("@")){
            return 'Please, enter a valid email address';
          } else if(value != user){
            return 'User does not exist';
          }
          return null;
        },
      ),
    );
  }

  bool checkPassword(String cadena) {
    // Expresión regular para verificar los criterios
    RegExp regex = RegExp(
        r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^|=&*()_+{}\[\]:;<>,.?~\\-])\S{8,}$');

    // Verificar si la cadena cumple con la expresión regular
    return regex.hasMatch(cadena);
  }

  Widget _passwordInput(){
    String password = 'A1_25678';
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
          } else if(!checkPassword(value)){
            return 'Password is not valid';
          } else if(value != password){
            return 'Password does not match';
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
                const SnackBar(
                  content: Center(
                    child: Text(
                      'Bienvenido a shopping list!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  backgroundColor: Colors.indigo,
                ),
              );
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen()));
            }
        }
      ),
    );
  }

}
