import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/model_product.dart';
import '../provider/product_provider.dart';

class EditProductPage extends StatefulWidget {
  final String data;
  EditProductPage(this.data, {Key? key}) : super(key: key);
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _imgUrlcontroller = TextEditingController();
  final _imgUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    title: '',
    desc: '',
    price: 0,
    imgURL: '',
  );
  var _initValues = {
    'title': '',
    'desc': '',
    'price': '',
    'imgUrl': '',
  };
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
    _imgUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final prodId = (widget.data == 'addProd') ? null : widget.data;
      if (prodId != null) {
        _editedProduct = Provider.of<Products>(context, listen: false).findById(prodId);
        _initValues = {
          'title': _editedProduct.title,
          'desc': _editedProduct.desc,
          'price': _editedProduct.price.toString(),
          // 'imgUrl': _editedProduct.imgURL,
        };
        _imgUrlcontroller.text = _editedProduct.imgURL;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imgUrlFocusNode.removeListener(_updateImageUrl);
    _imgUrlcontroller.dispose();
    _imgUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      if (_imgUrlcontroller.text == '' ||
          !_imgUrlcontroller.text.startsWith('http') ||
          (!_imgUrlcontroller.text.endsWith('png') &&
              !_imgUrlcontroller.text.endsWith('jpg') &&
              !_imgUrlcontroller.text.endsWith('jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _submitForm() {
    final _isValid = _formKey.currentState!.validate();
    if (!_isValid) return;
    _formKey.currentState!.save();
    if (_editedProduct.id.isNotEmpty) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit item'),
        actions: [
          IconButton(
            onPressed: () => _submitForm(),
            icon: const Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22).copyWith(top: 30),
          child: Form(
            key: _formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: const InputDecoration(
                    label: Text('Title'),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == '') {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: value!,
                      desc: _editedProduct.desc,
                      price: _editedProduct.price,
                      imgURL: _editedProduct.imgURL,
                    );
                  },
                ),
                const SizedBox(height: 18),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: const InputDecoration(
                    label: Text('Price'),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == '') return 'Please enter a value';
                    if (double.tryParse(value!) == null) return 'Please enter a valid number';
                    if (double.parse(value) <= 0) return 'Price should be greater than zero!';
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      desc: _editedProduct.desc,
                      price: double.parse(value!),
                      imgURL: _editedProduct.imgURL,
                    );
                  },
                ),
                const SizedBox(height: 18),
                TextFormField(
                  initialValue: _initValues['desc'],
                  decoration: const InputDecoration(
                    label: Text('Description'),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  validator: (value) {
                    if (value!.length < 20) {
                      return 'Description should be at leaset 20 charecters long';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      desc: value!,
                      price: _editedProduct.price,
                      imgURL: _editedProduct.imgURL,
                    );
                  },
                ),
                const SizedBox(height: 18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Image URL'),
                          border: OutlineInputBorder(),
                        ),
                        controller: _imgUrlcontroller,
                        keyboardType: TextInputType.url,
                        maxLines: 3,
                        textInputAction: TextInputAction.done,
                        focusNode: _imgUrlFocusNode,
                        validator: (value) {
                          if (value == '') return 'Please enter a URL';
                          if (!value!.startsWith('http') ||
                              (!value.endsWith('png') &&
                                  !value.endsWith('jpg') &&
                                  !value.endsWith('jpeg'))) {
                            return 'Please enter a valid image URL';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            desc: _editedProduct.desc,
                            price: _editedProduct.price,
                            imgURL: value!,
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(left: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: _imgUrlcontroller.text.isEmpty
                          ? const Center(
                              child: Text(
                                'Image\npreview',
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: Image.network(
                                _imgUrlcontroller.text,
                                // fit: BoxFit.contain,
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
