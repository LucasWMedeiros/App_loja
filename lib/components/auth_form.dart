import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  // ignore: prefer_final_fields
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _submit() {}

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 320,
        width: deviceSize.width * 0.75,
        child: Form(
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              onSaved: (email) => _authData['email'] = email ?? '',
              validator: (_email) {
                final email = _email ?? '';
                if (email.trim().isEmpty || email.contains('@')) {
                  return 'Informe um e-mail válido';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Senha'),
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              onSaved: (password) => _authData['password'] = password ?? '',
              controller: _passwordController,
              validator: (_password) {
                final password = _password ?? '';
                if (password.isEmpty) {
                  return 'Informe um senha valida';
                } else if (password.length < 5) {
                  return 'A senha deve ter no minimo 5 caracteres';
                }
                return null;
              },
            ),
            if (_authMode == AuthMode.Signup)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                validator: _authMode == AuthMode.Login
                    ? null
                    : (_password) {
                        final password = _password ?? '';
                        if (password != _passwordController) {
                          return 'Senhas informadas não conferem';
                        }
                        return null;
                      },
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _submit,
              // ignore: sort_child_properties_last
              child: Text(_authMode == AuthMode.Login ? 'Entrar' : 'REGISTRAR'),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8)),
            )
          ]),
        ),
      ),
    );
  }
}
