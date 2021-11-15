
import 'package:flutter/material.dart';
import 'package:learning_shop_app/providers/product.dart';
import 'package:learning_shop_app/providers/products.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product' ;

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

 final _priceFocusNode = FocusNode();
 final _descriptionFocusNode = FocusNode();
 final _imageUrlFocusNode = FocusNode();
 final _imageUrlController = TextEditingController() ;
 final _form = GlobalKey<FormState>();
var _editedProduct = Product(
    id: '',
    title: '',
    description: '',
    imageUrl: '',
    price: 0
);
var _isInit = true ;
var _isInitValues = {
  'title' : '',
  'description' : '',
  'imageUrl': '',
  'price' : ''
};

 @override
 void initState() {
   _imageUrlFocusNode.addListener(_updateImageUrl);
   super.initState();
 }

 @override
 void dispose()
 {
   super.dispose();
   _imageUrlFocusNode.removeListener(_updateImageUrl);
   _priceFocusNode.dispose();
   _descriptionFocusNode.dispose();
   _imageUrlController.dispose();
   _imageUrlFocusNode.dispose();
}
@override
  void didChangeDependencies() {

   if(_isInit)
     {
        final productId =  ModalRoute.of(context)!.settings.arguments as String ;
        if(productId != null)
          {
            _editedProduct = Provider.of<Products>(context,listen:false).findById(productId);
            _isInitValues = {
              'title' : _editedProduct.title,
              'description' : _editedProduct.description,
              'price' : _editedProduct.price.toString(),
              'imageUrl' : _editedProduct.imageUrl,
            };
          }
     }
    _isInit = false ;
    super.didChangeDependencies();
 }
void _updateImageUrl()
{
if(!_imageUrlFocusNode.hasFocus)
  {
    if( _imageUrlController.text.isEmpty ||
        (!_imageUrlController.text.startsWith('http') &&
        !_imageUrlController.text.startsWith('https')) ||
        !_imageUrlController.text.endsWith('.png') &&
        !_imageUrlController.text.startsWith('.jpg') &&
        !_imageUrlController.text.startsWith('.jpeg'))
      {
        return ;
      }

    setState(() {

    });
  }

}

void _saveForm()
{
  final valid =_form.currentState!.validate();
  // if(!valid)
  //   {
  //     return null ;
  //   }
  _form.currentState!.save();

  Provider.of<Products>(context, listen:false)
      .addProduct(_editedProduct);
  Navigator.of(context).pop();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title:const Text("Order"),
      actions: [
        IconButton(
          icon: Icon(Icons.save),
          onPressed: _saveForm,
        )
],
      ),
        
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,

            child: ListView(
              children: [
                TextFormField(
                  initialValue: _isInitValues['title'],
                  validator: (value)
                  {
                    if(value!.isEmpty)
                      return 'Please provide a value';

                    return null;

                  },
                  decoration :InputDecoration(labelText: 'Title' ),
                  textInputAction:  TextInputAction.next,
                  onFieldSubmitted: (value){
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (value)
                  {
                    _editedProduct = Product(
                        id: '',
                        title: value.toString(),
                        description: _editedProduct.description,
                        imageUrl: _editedProduct.imageUrl,
                        price: _editedProduct.price
                    );
                  },
                ),
                TextFormField(
                  initialValue: _isInitValues['price'],
                  decoration :InputDecoration(labelText: 'Price' ),
                  validator: (value)
                  {
                    if(value!.isEmpty)
                      return 'Please enter a price';
                    if(double.parse(value) <= 0 )
                      return 'Please enter greater value';

                    return null;

                  },
                  textInputAction:  TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (value){
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value)
                  {
                    _editedProduct = Product(
                        id: '',
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        imageUrl: _editedProduct.imageUrl,
                        price: double.parse(value!)
                    );
                  },
                ),
                TextFormField(
                  initialValue: _isInitValues['description'],
                  decoration :InputDecoration(labelText: 'Description' ),
                  validator: (value)
                  {
                    if(value!.isEmpty)
                      return 'Please enter a description';
                    if(value.length < 10)
                      return 'Should be  at least 10 haracters';

                    return null;

                  },
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (value)
                  {
                    _editedProduct = Product(
                        id: '',
                        title: _editedProduct.title,
                        description: value.toString(),
                        imageUrl: _editedProduct.imageUrl,
                        price: _editedProduct.price
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width :100 ,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration:BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        )
                      ),
                    child: _imageUrlController.text.isEmpty
                        ?
                    Text('Enter a URL')
                        :
                        FittedBox(
                          child: Image.network(_imageUrlController.text),
                          fit: BoxFit.cover,
                        )
                    ),
                    Expanded(
                        child: TextFormField(
                          initialValue: _isInitValues['imageUrl'],

                          decoration: InputDecoration(labelText: 'Image URL'),
                          validator: (value)
                          {

                            return null;

                          },
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          focusNode: _imageUrlFocusNode,
                          onFieldSubmitted: (_) { _saveForm();
                          } ,
                          onSaved: (value)
                          {
                            _editedProduct = Product(
                                id: '',
                                title: _editedProduct.title,
                                description: value.toString(),
                                imageUrl: value.toString(),
                                price: _editedProduct.price
                            );
                          },
                          controller: _imageUrlController ,
                          onEditingComplete: () {
                            setState(() {});
                          },
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
