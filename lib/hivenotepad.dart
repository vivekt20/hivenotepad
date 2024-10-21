

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState()=>_HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  late Box box;
  List<Map<String,String>>itemList=[];

  TextEditingController titlecontroller=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController dateController=TextEditingController();
  TextEditingController CategoryController=TextEditingController();
  @override
  void initState() {
    super.initState();
    box=Hive.box('mybox');

    final storedItems=box.get('itemlist');
    if(storedItems is List){
      itemList=List<Map<String,String>>.from(
        storedItems.map((e)=>Map<String,String>.from(e)));
      
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(itemCount: itemList.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10), itemBuilder: (context,index){
         final item=itemList[index];
          return Container(
            height: 100,
            width: 150,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title']??'No title'),
                Text(item['description']?? 'No description'),
                Text(item['category']?? 'No category'),
                Text(item['Date']?? 'No date'),
              ],
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(context: context, builder: (BuildContext context){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [TextField(
                controller: titlecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 5,
                    )
                  ),
                  hintText: "Title...",
                ),
              ),
              SizedBox(height: 15),
              TextField(controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 5,
                  )
                ),
                hintText: "Description.."
              ),),
              SizedBox(height: 15),
              TextField(controller: CategoryController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 5,
                  )
                ),
                hintText: "Category.."
              ),),
              SizedBox(height: 15),
              TextField(controller: dateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 5,
                  )
                ),
                hintText: "Date",
              ),),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ElevatedButton(onPressed: (){
                  setState(() {
                    itemList.add({
                      'title':titlecontroller.text,
                      'discription':descriptionController.text,
                      'category':CategoryController.text,
                      'date':dateController.text,
                    });
                    box.put('itemList', itemList.map((e)=>Map<String,dynamic>.from(e)).toList());
                  });
                  titlecontroller.clear();
                  descriptionController.clear();
                  CategoryController.clear();
                  dateController.clear();

                  Navigator.pop(context);
                }, child: Text("Add")),
                SizedBox(width: 15),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel"))
                ],
              )
              
              ],
            ),
          );
        });
      },
      child: Icon(Icons.add),),
    );
  }
}