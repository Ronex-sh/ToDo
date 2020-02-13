import 'package:flutter/material.dart';
import 'package:todo2/home.dart';

void main() => runApp(StartupPoint());
class StartupPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo Application',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Splash( title: 'ToDo'),
    );
  }
}
class Splash extends StatefulWidget {
 final String title;
  Splash({Key key,this.title}):super(key:key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin{
  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
  _controller=AnimationController(vsync: this,duration: Duration(milliseconds: 4000));
  _animation=CurvedAnimation(parent: _controller,curve:Curves.easeInToLinear );
  _controller.forward();
  Future.delayed(Duration(seconds: 4),(){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return Home(title:widget.title);
    }));
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar( title:Text(widget.title)) ,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Text('Todo'),
              SizedBox(height: 8,),
              Text('2020')
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),),
    );
  }
}