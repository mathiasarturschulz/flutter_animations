import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// variavel que controla o número de vacinas, por padrão começa em 19897
var numVacinas = 19897;

// Widget principal da aplicação
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Start(),
    );
  }
}

class Start extends StatefulWidget {
  Start({Key key}) : super(key: key);
  _Start createState() => _Start();
}

class _Start extends State {
  // variavel que controla a página atual
  var _currentPage = 0;
  var _pages = [
    PageCadastro(),
    PageInformacoes(),
    PageSobre(),
  ];

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Vacinação COVID-19'),
        ),
        body: Center(child: _pages.elementAt(_currentPage)),
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline), 
                  label: 'Cadastro',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assessment_outlined),
                  label: 'Informações',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_ind_rounded),
                  label: 'Sobre'
              ),
            ],
            currentIndex: _currentPage,
            fixedColor: Colors.purple,
            onTap: (int inIndex) {
              setState(() {
                _currentPage = inIndex;
              });
            }),
      ),
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
    );
  }
}

class Usuario {
  String nome = '';
  String cpf = '';
  String email = '';
}

class PageCadastro extends StatelessWidget {
  Usuario _usuario = new Usuario();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    Paint paint = Paint();
    paint.color = Colors.green;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 50),
        child: Form(
          key: this._formKey,
          child: Column(
            children: [
              // cadastro
              Text(
                'Cadastro', 
                style: TextStyle(
                  background: paint,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              // campo nome
              TextFormField(
                keyboardType: TextInputType.name,
                validator: (String value) {
                  print(value);
                  if (value.length == 0) {
                    return 'O campo de nome é obrigatório';
                  }
                  return null;
                },
                onSaved: (String value) {
                  this._usuario.nome = value;
                },
                decoration: InputDecoration(
                    hintText: 'Fulano da Silva',
                    labelText: 'Nome',
                ),
              ),
              // campo cpf
              TextFormField(
                keyboardType: TextInputType.text,
                validator: (String value) {
                  print(value);
                  if (value.length != 11) {
                    return 'O campo de CPF é obrigatório e deve possuir 11 caracteres';
                  }
                  return null;
                },
                onSaved: (String value) {
                  this._usuario.cpf = value;
                },
                decoration: InputDecoration(
                    hintText: 'xxxyyyzzzww',
                    labelText: 'CPF (Sem pontuação)',
                ),
              ),
              // campo email
              TextFormField(
                keyboardType: TextInputType.name,
                validator: (String value) {
                  print(value);
                  if (value.length == 0) {
                    return 'O campo de e-mail é obrigatório';
                  }
                  return null;
                },
                onSaved: (String value) {
                  this._usuario.email = value;
                },
                decoration: InputDecoration(
                    hintText: 'nome@servidor',
                    labelText: 'E-mail',
                ),
              ),
              // botão
              Padding(
                padding: EdgeInsets.only(top: 16, left: 250),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // informa uma mensagem de sucesso
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Vacinação registrada com sucesso! '),
                        action: SnackBarAction(label: 'Fechar', onPressed:(){}),
                      ));
                      // apresenta algumas informações
                      print('=> Cadastro do usuário: ');
                      print('Nome: ${_usuario.nome}');
                      print('E-mail: ${_usuario.email}');
                      print('CPF: ${_usuario.cpf}');
                      _formKey.currentState.save();
                      numVacinas += 1;
                      // reseta o formulário
                      _formKey.currentState.reset();
                    }
                  },
                  child: Text('Gravar'),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}

class PageInformacoes extends StatefulWidget {
  @override
  _PageInformacoesState createState() => _PageInformacoesState();
}

class _PageInformacoesState extends State<PageInformacoes> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation colorAnimation;
  Animation sizeAnimation;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void initState() {
    super.initState();
    controller =  AnimationController(vsync: this, duration: Duration(seconds: 2));
    colorAnimation = ColorTween(begin: Colors.blue, end: Colors.yellow).animate(controller);
    sizeAnimation = Tween<double>(begin: 150.0, end: 300.0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    controller.repeat();
    controller.repeat(reverse: true);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 50),
        child: Form(
          key: this._formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: new RotationTransition(
                  turns: new AlwaysStoppedAnimation(-15 / 360),
                  child: new Text(
                    'Informações',
                    style: TextStyle(
                      fontSize: 30,
                      foreground: Paint() ..style = PaintingStyle.stroke ..strokeWidth = 4 ..color = Colors.blue[700],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Container(
                  height: sizeAnimation.value,
                  width: sizeAnimation.value,
                  color: colorAnimation.value,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Número de pessoas cadastradas para vacinação: ' + numVacinas.toString(), 
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class PageSobre extends StatefulWidget {
  _PageSobreState createState() => _PageSobreState();
}

class _PageSobreState extends State<PageSobre> with SingleTickerProviderStateMixin {
  static const Color beginColor = Colors.deepPurple;
  static const Color endColor = Colors.deepOrange;
  Duration duration = Duration(milliseconds: 800);
  AnimationController controller;
  Animation<Color> animation;
  static const optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration);
    animation = ColorTween(begin: beginColor, end: endColor).animate(controller);
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 50),
        child: Form(
          key: this._formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Sobre', 
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.purple,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Governo Federal do Brasil',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return MaterialButton(
                    color: animation.value,
                    height: 50,
                    minWidth: 100,
                    child: child,
                    onPressed: () {
                      if (controller.status == AnimationStatus.completed) {
                        controller.reverse();
                      } else {
                        controller.forward();
                      }
                    },
                  );
                },
                child: Text(
                  'Trocar de Cor',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
