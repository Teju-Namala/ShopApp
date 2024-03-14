import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailsPage({super.key,required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  int selectedSize=0;

  void onTap () {
    if(selectedSize!=0){
    Provider.of<CartProvider>(context,listen: false)
    .addProduct({
    'id': widget.product['id'],
    'title': widget.product['title'],
    'price': widget.product['price'],
    'imageUrl': widget.product['imageUrl'],
    'company': widget.product['company'],
    'sizes':selectedSize,
    },
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Center(
          child: Text('Product Added Successfully', style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),),
        )
      )
    );
   }
   else{
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Center(
          child: Text('Please Select a Size', style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),),
        )
      )
    );
   }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Center(child:Text('Details',style: TextStyle(
          fontWeight: FontWeight.bold
        ),),),
      ),
      body: Column(
        children: [
          Center(
            child: Text(widget.product['title'] as String,
              style:const TextStyle(fontSize: 25,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset(widget.product['imageUrl'] as String),
          ),
          const Spacer(flex: 1,),
          Container(
            height: 250,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(245, 247, 249, 1),
              borderRadius:BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('\$${widget.product['price']}',style:const TextStyle(fontSize: 25,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold),
                        ),
                  ),
                      // const SizedBox(height: ,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:(widget.product['sizes'] as List<int>).length,
                        itemBuilder:(context, index) {
                          final size=(widget.product['sizes'] as List<int>)[index];
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize=size;
                                });
                              },
                              child: Chip(
                                label: Text(size.toString(),style:const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lato',
                                ),),
                                backgroundColor: selectedSize==size ? Colors.yellow: null,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                                ),
                                side:const BorderSide(color: Colors.black),
                              ),
                            ),
                          );
                      },),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(19.0),
                    child: ElevatedButton(onPressed: onTap, 
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.yellow),
                      minimumSize: MaterialStatePropertyAll(Size(double.infinity, 55))
                    ),
                    child:const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined,color: Colors.black,),
                        SizedBox(width: 5,),
                        Text('Add to cart',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    ),
                  )
                ],
              ),
          ),
        ],
      ),
    );
  }
}