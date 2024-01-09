import 'package:flutter/material.dart';
import 'package:gestionaire/context/cartprovider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VendreActionCart extends StatefulWidget {
  const VendreActionCart({super.key});

  @override
  State<VendreActionCart> createState() => _VendreActionCartState();
}

class _VendreActionCartState extends State<VendreActionCart> {
  final _date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartNotifier>(context);
    List<CartItem>cart = cartData.cart; 
    void Function(CartItem) remove = cartData.removeTocart;
    void Function(CartItem) increment = cartData.increment;
    void Function(CartItem) decrement = cartData.decrement;
    cartData.calculateTotal();
    int total = cartData.total;
    return Scaffold(
      appBar: AppBar(
        title: Text("Effectuer les ventes",
            style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.purple)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: const [
          Icon(Icons.shopify_rounded, color: Colors.purple, size: 34),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            
            Column(
              children: cart.map((e){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 1),
                        Text(e.name.toUpperCase(),
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.purple[400]
                            )),
                        Text("${e.prixVente*e.quantity}", style: GoogleFonts.roboto(fontSize: 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                  decrement(e);
                              },
                              icon: const Icon(Icons.remove_outlined, size: 30),
                            ),
                            Text("${e.quantity}",
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.purple[400])),
                            IconButton(
                              onPressed: () {
                                increment(e);
                              },
                              icon: const Icon(Icons.add, size: 30),
                            ),
                            IconButton(
                              onPressed: () {
                                remove(e);
                              },
                              icon: const Icon(Icons.cancel, size: 30),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }).toList()
            ),
           
           
          ],
        ),
      )),
      bottomNavigationBar: Container(
        height: 120, 
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.only( 
            topLeft: Radius.circular(20), 
            topRight: Radius.circular(20)
          )
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ 
            Row(
              children: [ 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total:",style: GoogleFonts.roboto(fontSize: 20, color:Colors.white, fontWeight: FontWeight.w600),),
                    Row(
                      children: [
                        const Icon(Icons.monetization_on, size:24, color:Colors.amber),
                        const SizedBox(width: 10),
                        Text("$total fcfa",style: GoogleFonts.roboto(fontSize: 20, color:Colors.white, fontWeight: FontWeight.w600),),
                      ],
                    )
                  ],
                )
              ],
            ), 
             Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(100, 50),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _date,
                                  keyboardType: TextInputType.datetime,
                                ),
                                ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      minimumSize: const Size(300, 50),
                                    ),
                                    onPressed: () {},
                                    icon: const Icon(Icons.save,
                                        size: 30, color: Colors.white),
                                    label: Text("Enregistrer la vente",
                                        style: GoogleFonts.roboto(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600))),
                              ],
                            ),
                          );
                        });
                  },
                  icon: const Icon(Icons.calendar_month_rounded,
                      size: 30, color: Colors.red),
                  label: Text("Date",
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600))),
            )
          ],
        ),
      ),
    );
  }
}
