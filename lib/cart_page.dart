import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:shop_app/cart_provider.dart";

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        )),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];
          return ListTile(
            title: Text(
              cartItem['title'].toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(
                cartItem['imageUrl'] as String,
              ),
            ),
            subtitle: Text('Size: ${cartItem['sizes']}'),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Delete Product',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: const Text('Are you Sure?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w900),
                            )),
                        TextButton(
                            onPressed: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .removeProduct(cartItem);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Yes',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w900)))
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.delete,
                size: 38,
              ),
              style: const ButtonStyle(
                iconColor: MaterialStatePropertyAll(
                  Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
