import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';

import '../../../commons/widgets.dart';
import '../../../main.dart';


class paymentMethod extends StatefulWidget {
  const paymentMethod({super.key});

  @override
  State<paymentMethod> createState() => _paymentMethodState();
}

class _paymentMethodState extends State<paymentMethod> {
  String cont="G";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Pallette.white,
        toolbarHeight: height*0.04,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )),
        title: Text("Payment",style: TextStyle(fontWeight: FontWeight.w600,fontSize: width*0.05),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height:height*0.06,
              width: width*1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width*0.03),
                border: Border.all(color: Pallette.primaryColor)
              ),
              child: ListTile(
                title: Text("Google Pay",style: TextStyle(color: CupertinoColors.black,),),
                trailing:Radio(
                  activeColor: Pallette.primaryColor,
                  fillColor: MaterialStatePropertyAll(Pallette.primaryColor),
                  value: "G",
                  groupValue: cont,
                  onChanged: (value) {
                    setState(() {
                      cont=value!;
                    });
                  },
                ) ,
              ),
            ),
            gap,
            Container(
              height:height*0.06,
              width: width*1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width*0.03),
                border: Border.all(color: Pallette.primaryColor)
              ),
              child: ListTile(
                title: Text("Credit/Debit",style: TextStyle(color: CupertinoColors.black,),),
                trailing:Radio(
                  activeColor: Pallette.primaryColor,
                  fillColor: MaterialStatePropertyAll(Pallette.primaryColor),
                  value: "C",
                  groupValue: cont,
                  onChanged: (value) {
                    setState(() {
                      cont=value!;
                    });
                  },
                ) ,
              ),
            ),
            gap,
            Container(
              height:height*0.06,
              width: width*1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width*0.03),
                border: Border.all(color: Pallette.primaryColor)
              ),
              child: ListTile(
                title: Text("COD",style: TextStyle(color: CupertinoColors.black,),),
                trailing:Radio(
                  activeColor: Pallette.primaryColor,
                  fillColor: MaterialStatePropertyAll(Pallette.primaryColor),
                  value: "D",
                  groupValue: cont,
                  onChanged: (value) {
                    setState(() {
                      cont=value!;
                    });
                  },
                ) ,
              ),
            ),
            gap,
            gap,
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width*0.05)
                        ),
                        content: Container(
                          height: height*0.5,
                          width: width*1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width*0.03)
                          ),
                          child: Column(
                            children: [
                              Lottie.asset(imageConstants.lottie),
                              Text("Successfully Ordered!!")
                            ],
                          ),
                        ),
                      );
                    }
                );
              },
              child: Container(
                height: height*0.06,
                width: width*0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.3),
                    color:Pallette.primaryColor
                ),
                child: Center(
                  child: Text("Continue",style: TextStyle(
                      color: Pallette.white,
                      fontSize: width*0.04,
                      fontWeight: FontWeight.w600
                  ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
