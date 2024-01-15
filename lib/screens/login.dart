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
    //TODO Activ3: Variable para el usuario
    String user = 'Adrian@gmail.com';
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
          color: Colors.white,
        border: Border.all(
          color: Colors.teal.shade300,
        )
      ),
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
            //TOOD Activ3: si el valor no contiene @, la validación fallará
          } else if(!value.contains("@")){
            return 'Please, enter a valid email address';
            //TODO Activ3: si el valor no es igual al usuario, la validación fallará
          } else if(value != user){
            return 'User does not exist';
          }
          return null;
        },
      ),
    );
  }

  //TODO Activ3: Método bool que usa una expresión regular para validar si la contraseña cumple los requisitos
  bool checkPassword(String cadena) {
    RegExp regex = RegExp(
        r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^|=&*()_+{}\[\]:;<>,.?~\\-])\S{8,}$');
    return regex.hasMatch(cadena);
  }

  Widget _passwordInput(){
    //TODO Activ3: Variable para la contraseña
    String password = 'A1_25678';
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.teal.shade300,
          )
      ),
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
            //TODO Activ3: si el valor no cumple con los requisitos del método checkPassword, la validación fallará
          } else if(!checkPassword(value)){
            return 'Password is not valid';
            //TODO Activ3: si el valor no es igual a la contraseña creada, la validación fallará
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
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal.shade400,
        ),
        child: const Text('Login', style: TextStyle(
          color: Colors.white
        ),),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Center(
                    child: Text(
                      'Bienvenido a shopping list!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  backgroundColor: Colors.teal,
                ),
              );
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen()));
            }
        }
      ),
    );
  }
}
