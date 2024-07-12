import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Shopping extends StatefulWidget {
  const Shopping({super.key});

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  final _minimumPadding = 5.0;

  TextEditingController purchaseAmountController = TextEditingController();
  int noOfItem= 1;
  var displayResult = "";
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize:Size.fromHeight(100.0),
          child:  AppBar(
            //centerTitle: true,
            backgroundColor: Color(0xFF91C8E4),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40),
              ),
            ),
            title: Center(
              child: Text(
                "Shopping", style: TextStyle(fontSize: 40),
              ),
            ),
          ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFF6F4EB),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding*2, bottom: _minimumPadding*2),
                  child: Row(
                    children: [
                      Text("Total Purchase ₹:",style: TextStyle(fontSize: 20) ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: purchaseAmountController,
                            validator: (value){
                              if(value ==""){
                                return "Enter Purchase Amt. ";
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Purchase Amt.',
                                hintText: "Enter Purchase Amount e.g :500",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                )),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(height: 10,),
              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding*2, bottom: _minimumPadding*2),
                  child: Row(
                    children: [
                      Text("No of Item :",style: TextStyle(fontSize: 20)),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              child: IconButton(onPressed: (){
                                setState(() {
                                  noOfItem =  add(noOfItem);
                                });

                              },
                                icon: Icon(Icons.add),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color(0xFF91C8E4)
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(_minimumPadding * 2),
                              child: Text(noOfItem.toString(),
                              ),
                            ),
                            Container(
                              child: IconButton(onPressed: (){
                                setState(() {
                                  if(noOfItem!=0){
                                  noOfItem =  sub(noOfItem);}
                                });
                              },

                                icon: Icon(CupertinoIcons.minus),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Color(0xFF91C8E4)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
          Row(
            children: [
              Text("Have any coupon code:",style: TextStyle(fontSize: 20) ),
              Checkbox(
                checkColor: Colors.white,
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
            ],
          ),
              Padding(
                padding:EdgeInsets.all(_minimumPadding*5),
                child: ElevatedButton(onPressed: (){
                  setState(() {
                    this.displayResult = _calculateTotalDiscount();
                  });
                },
                    child: Text("Apply Discounrt"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF749bc2),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),

                ),
              ),
              Padding(
                padding: EdgeInsets.all(_minimumPadding * 3),
                child: Container(

                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: Color(0xFF91C8E4),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        this.displayResult,style: TextStyle(fontSize:23),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  int add(noOfItem){
    return noOfItem+1;
  }

  int sub(noOfItem){
    return noOfItem-1;
  }

  String _calculateTotalDiscount() {
    double purchase = double.parse(purchaseAmountController.text);
    double discount;
    double? amountToPaid;
    double? totalValueOfPurchase;
    if((purchase >= 1000) && (isChecked == false) ) {
      totalValueOfPurchase = purchase * noOfItem;
      discount = (totalValueOfPurchase*10) / 100;
      amountToPaid = totalValueOfPurchase - discount;
    }
       else if( noOfItem>=5){
      totalValueOfPurchase= purchase*noOfItem;
      discount = (totalValueOfPurchase*5) /100;
      amountToPaid = totalValueOfPurchase-discount;
    }
       else if(purchase >=1000 && noOfItem>=5){
       totalValueOfPurchase= purchase*noOfItem;
       discount =(totalValueOfPurchase*15) /100;
       amountToPaid = totalValueOfPurchase-discount;
    }
       else if(isChecked= true){
         totalValueOfPurchase = purchase* noOfItem;
         discount = (totalValueOfPurchase*20)/100;
         amountToPaid= totalValueOfPurchase-discount;
    }
       else {
      amountToPaid= totalValueOfPurchase;
    }
    String result =
        " Your have to pay : ${amountToPaid}";
    return result;
  }



}
