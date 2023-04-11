
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jupiter_web_app/model/link_model.dart';
import 'package:jupiter_web_app/pages/webview.dart';
import 'package:jupiter_web_app/provider/link_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName='homepage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LinkProvider linkProvider;
  AddLinkModel? newlink;
  TextEditingController titleController = TextEditingController();
  TextEditingController linkcontroller = TextEditingController();
  @override
  void didChangeDependencies() {
    linkProvider = Provider.of<LinkProvider>(context, listen: true);
    linkProvider.getallLinkss();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8E1E1),
      body: Center(
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Consumer<LinkProvider>(
    builder: (context, provider, child) {
    List<AddLinkModel> linklist =
    provider.linklist;
    return
           SizedBox(
             child: ListView.builder(
                  physics:
                  const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: linklist.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WebView(
                                  link:"https://${linklist[linklist.length-index-1].link_address}",
                                ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets
                            .symmetric(
                            vertical: 12,horizontal: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width-12,
                          height: 70.h,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors
                                      .white
                                      .withOpacity(
                                      0.3),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0,
                                      0), // Shadow position
                                ),
                              ],
                              borderRadius:
                              BorderRadius
                                  .circular(30),
                              border: Border.all(
                                  width: 1,
                                  color: Colors
                                      .white
                                      .withOpacity(
                                      0.7)),
                              color: Colors
                                  .transparent),
                          child: SizedBox(
                            height: 70.h,
                            width: MediaQuery.of(context).size.width-12,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height: 50.h,
                                    child: Column(
                                      children: [
                                        Text(
                                          linklist[linklist.length-index-1].link_name,
                                          textAlign:
                                          TextAlign
                                              .center,
                                          maxLines: 2,
                                          overflow:
                                          TextOverflow
                                              .ellipsis,
                                          style: TextStyle(
                                              fontSize: 20
                                                  .sp,
                                              color: Colors
                                                  .black,
                                              fontWeight:
                                              FontWeight.w600),
                                        ),
                                        SizedBox(height: 10.h,),
                                        Text(
                                          linklist[linklist.length-index-1].link_address!,
                                          textAlign:
                                          TextAlign
                                              .center,
                                          maxLines: 2,
                                          overflow:
                                          TextOverflow
                                              .ellipsis,
                                          style: TextStyle(
                                              fontSize: 18
                                                  .sp,
                                              color: Colors
                                                  .black,
                                              fontWeight:
                                              FontWeight.w600),
                                        ),
                                      ],
                                    )
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
          );})
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMyDialog();
        },
        elevation: 3,
        hoverColor: Colors.amber,
        backgroundColor: Colors.green.withOpacity(0.5),
        child: const Icon(Icons.add),
      ),
    );
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: const Text('Add More')),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                SizedBox(
                  height: 50,
                  width: 440,
                  child: TextFormField(
                    controller: titleController,
                    decoration:   InputDecoration(
                        focusedBorder:   OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                          BorderSide(color: Colors.black), //<-- SEE HERE
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                          BorderSide(color: Colors.grey), //<-- SEE HERE
                        ),
                        filled: false,
                        // prefixIcon: Icon(Icons.email_outlined,color: Colors.black,),
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 14),
                        hintText: 'Website Name (Optional)'),
                  ),
                ),
                SizedBox(height: 15.h,),
                SizedBox(
                  height: 50,
                  width: 440,
                  child: TextFormField(
                    controller: linkcontroller,
                    decoration:   InputDecoration(
                        focusedBorder:   OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                          BorderSide(color: Colors.black), //<-- SEE HERE
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                          BorderSide(color: Colors.grey), //<-- SEE HERE
                        ),
                        filled: false,
                        // prefixIcon: Icon(Icons.email_outlined,color: Colors.black,),
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 14),
                        hintText: 'Website Link (Required)'),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  addlinks();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void addlinks() async{
    final links = AddLinkModel(
        link_name:titleController.text!,
        link_address: linkcontroller.text!,

    );
    print(links.toString());
    bool already=false;
      final status = await Provider
          .of<LinkProvider>(context, listen: false).addlink(links);
      if(status){
        print('Succesfuly Added');
        titleController.text='';
        linkcontroller.text='';
      }
    }
}
