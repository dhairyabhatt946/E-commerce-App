import 'package:ecommerce_admin_app/containers/additional_confirm.dart';
import 'package:ecommerce_admin_app/controllers/db_service.dart';
import 'package:ecommerce_admin_app/models/products_model.dart';
import 'package:ecommerce_admin_app/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: Consumer<AdminProvider>(builder: (context, value, child) {
        List<ProductsModel> products = ProductsModel.fromJsonList(value.products);

        if(products.isEmpty) {
          return Center(child: Text("No Products Found"),);
        }

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ListTile(
              onLongPress: () {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: Text("Choose what you want"),
                    content: Text("Delete cannot be undone"),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                        showDialog(context: context, builder: (context) {
                          return AdditionalConfirm(contentText: "Are you sure?", onYes: () {
                            DbService().deleteProduct(docId: products[index].id);
                            Navigator.pop(context);
                          }, onNo: () {
                            Navigator.pop(context);
                          });
                        },);
                      }, child: Text("Delete Product")),
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/add_product", arguments: products[index]);
                      }, child: Text("Edit Product"))
                    ],
                  );
                },);
              },
              onTap: () {
                Navigator.pushNamed(context, "/view_product", arguments: products[index]);
              },
              leading: Container(
                height: 50,
                width: 50,
                child: Image.network(products[index].image == null || products[index].image == "" ?
                "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg" : products[index].image),
              ),
              title: Text(products[index].name, maxLines: 2, overflow: TextOverflow.ellipsis,),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Rs. ${products[index].new_price.toString()}"),
                  Container(
                      padding: EdgeInsets.all(4),
                      color: Theme.of(context).primaryColor,
                      child: Text(products[index].category.toUpperCase(), style: TextStyle(color: Colors.white),)
                  )
                ],
              ),
              trailing: IconButton(onPressed: () {
                Navigator.pushNamed(context, "/add_product", arguments: products[index]);
              }, icon: Icon(Icons.edit_outlined)),
            );
          },
        );
      },),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/add_product");
        },
      ),
    );
  }
}
