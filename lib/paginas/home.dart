import 'package:flutter/material.dart';
import 'package:vision_one/modelo/mysql.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  var db = new Mysql();

  @override
  Widget build(BuildContext context) {

    final tamano = MediaQuery.of(context).size;  
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appbar(tamano),
          SliverList(delegate: SliverChildListDelegate(
              [ _body(tamano) ]
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: null 
        //() => Navigator.pushNamed(context, 'admin_seccion'),
      ),
    );
  }

  Widget _appbar(tamano) {

    return SliverAppBar(
      title: Row(
        children: [
          Expanded(child: SizedBox()),
          Center(child: Text('Catalogo de productos')),
          Expanded(child: SizedBox()),
          TextButton(
            //icon: Icon(Icons.ad),
            style: TextButton.styleFrom(
              backgroundColor: Colors.black12,
              elevation: 0.9
            ),            
            child: Text('administrar usuarios', style: TextStyle(color: Colors.white, fontSize: 13.0)),
            onPressed:() => Navigator.pushNamed(context, 'admin_user')
          )
        ],
      ),
    );
              
  }

  Widget _body(Size tamano) {

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: tamano.width * 1.0,
            height: tamano.height * 0.5,
            child: _secciones(),
          ),
          //SizedBox(height: 80.0),
        ]
      ),
    );

  }

  Widget _secciones() {

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'productos'),
      child: ListTile(
        title: Text('Baterías'),
      ),
    );

  }
              

}