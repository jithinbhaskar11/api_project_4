import 'package:api_project_4/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

  HomeScreenController homeScreenController= HomeScreenController();

  var nameController=TextEditingController();
  var descController=TextEditingController();
  @override
  void initState() {
    fetchData();
    super.initState();
  }

 Future fetchData()  async{
   await homeScreenController.getData();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: homeScreenController.modelobj?.employees?.length,
          itemBuilder: (ctx,index){
        return ListTile(
          title: Text(homeScreenController.modelobj?.employees?[index].employeeName ??""),
          subtitle: Text(homeScreenController.modelobj?.employees?[index].designation ?? ""),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: (){
                showModalBottomSheet(context: context, builder: (context) => Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(onPressed: (){},
                            child: Text('Update'),color: Colors.blue,),
                          SizedBox(width: 20,),
                          MaterialButton(onPressed: (){},
                            child: Text('SAVE'),color: Colors.blue,),
                        ],
                      )
                    ],
                  ),
                ),);
              }, icon: Icon(Icons.edit)),

              IconButton(onPressed: ()async{
               await homeScreenController.deleteData(homeScreenController.modelobj?.employees?[index].id ?? "");
               homeScreenController.getData();
                setState(() {

                });
              }, icon: Icon(Icons.delete))
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(
            isScrollControlled: true,
            context: context, builder: (BuildContext buildcontext){
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Name')
                      ),
                    ),
                    SizedBox(height:10 ,),
                    TextField(
                      controller: descController,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                      label: Text('Description')
            ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(onPressed: (){
                          Navigator.pop(context);
                        },
                          child: Text('cancel'),color: Colors.blue,),
                        SizedBox(width: 20,),
                        MaterialButton(onPressed: ()async{
                          Navigator.pop(context);
                         await homeScreenController.addData(nameController.text, descController.text);
                         setState(() {

                         });
                        },
                        child: Text('SAVE'),color: Colors.blue,),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
        child: Icon(Icons.file_copy),),
    );
  }
}
