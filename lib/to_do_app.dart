import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
 final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  final List<String> _todo = [];

 void addTodo(String todo){
    setState(() {
    //  _todo = [..._todo,todo];
    _todo.add(todo);
   
    });
  }

  void deleteTodo(int index){
   setState(() {
      _todo.removeAt(index);
   });
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 250, 249, 249),
        elevation: 10,
       backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){}, 
          icon: const Icon(Icons.menu,color: Color.fromARGB(255, 47, 2, 245),)),
        centerTitle: true,
        title: const Text("My Todo App",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,color: Color.fromARGB(255, 13, 5, 246)),),
        actions: const [
          Icon(Icons.notification_add, color: Color.fromARGB(253, 0, 8, 244),),
          SizedBox(width: 5,),
          Padding(
            padding: EdgeInsets.only(right: 15,left: 10),
            child: Icon(Icons.person,color: Color.fromARGB(255, 4, 24, 246),),
          )
          ],
      ),



//Listvew and list tile
      body:SingleChildScrollView(
        child: Column(
          children: [
          SizedBox(
            height: 500,
            child: ListView.separated(
            itemCount: _todo.length,
            separatorBuilder: (context,index){
              return const SizedBox(
                height: 5,
              );
            },


    //list tile container        
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 15, left: 10,right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: const Border.symmetric(
                      vertical: BorderSide(color: Colors.blue,width: 1),
                      ),
                    borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      blurRadius: 10,
                      blurStyle: BlurStyle.outer)
                  ],
                 ),


  //list tile
                  child: ListTile(
                    title: Text(_todo[index],style: const TextStyle(fontWeight: FontWeight.bold),),
                    tileColor: Colors.white,
                    leading:const CustomCheckBox(),
                    subtitle: Text(DateTimeNow().getCurrentDateTime()),

      //Alert DialogBox              
                    trailing: IconButton(onPressed: (){
                     showDialog(context: context, builder: (BuildContext context) {
               return AlertDialog(
                title: const Text("Are you sure you want to delete this item?",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                textAlign: TextAlign.center,),
                content:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(onPressed: (){
                    Navigator.pop(context);
                     }, child: const Text("Cancel")),
                    
                    TextButton(onPressed: (){
                    deleteTodo(index);
                     Navigator.pop(context);
                    }, child:  const Text("Delete")),
                  ],
                ),
               );
             });
                    }, icon: const Icon(Icons.delete_forever,color: Colors.blue,))     
                   ),
                ),
              );
            })),
          ),
          ],
        ),
      ) ,




  //floating action button
      floatingActionButton:   Padding(
        padding: const EdgeInsets.only(bottom: 15,right: 5),
        child: FloatingActionButton(onPressed: (){
              //showBottomSheet();
             showDialog(context: context, builder: (BuildContext context) {
               return AlertDialog(
                title: const Text("Enter Text",textAlign: TextAlign.center,),
                content:Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ModalTextField(controller: textController,),
                   const SizedBox(height: 10,),
        
           //save and cancel buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(onPressed: (){
                         addTodo(textController.text);
                         textController.clear();
                        Navigator.pop(context);
                         }, child: const Text("Save")),
                        
                        TextButton(onPressed: (){
                        Navigator.pop(context);
                        }, child:  const Text("Cancel")),
                      ],
                    )
                  ],
                ),
               );
             });
            },
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: Colors.blue,
             tooltip: 'Add a to-do',
              child: const Icon(Icons.edit),
              ),
      ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );

  }
}


class ModalTextField extends StatefulWidget {
   final TextEditingController controller;
  const ModalTextField({super.key,
  required this.controller
  });

  @override
  State<ModalTextField> createState() => _ModalTextFieldState();
}

class _ModalTextFieldState extends State<ModalTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child:  TextField(
            maxLines: 1,
            controller: widget.controller,
             style: const TextStyle(color: Colors.black,),
             decoration: const InputDecoration(
              hintText: "Enter here",
              hintStyle: TextStyle(color: Colors.grey,)
             ),
          ),
        ),

        
      ],
    );
  }
}


class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
   
      child: IconButton(onPressed: (){
        setState(() {
          isChecked =!isChecked;
        });
      }, icon: isChecked? const Icon(Icons.check_box,color: Color.fromARGB(255, 5, 5, 238),
      size: 18,
      // color: Colors.white,
      )
      : const Icon(Icons.check_box_outline_blank, size:24,color: Colors.blue,)

      ));
    
    // GestureDetector(
    //   onTap: (){
    //     setState(() {
    //       isChecked = !isChecked;
    //     });
    //   },
    //   child: Container(
    //       width: 24,
    //   height:24,
    //   decoration: BoxDecoration(
    //     border: Border.all(
    //       color:const Color.fromARGB(255, 51, 33, 243)),
    //     borderRadius: const BorderRadius.all(Radius.circular(4)),
    //     color:  isChecked? Colors.blue: Colors.white
    //   ),
    //   child: isChecked
    //   ? const Icon(Icons.check,
    //   size: 18,
    //   color: Colors.white,)
    //   :null,
    //   ),
    
    // );
  }
}


class DateTimeNow{
  String getCurrentDateTime(){
    return DateTime.now().toString();
  }
}

