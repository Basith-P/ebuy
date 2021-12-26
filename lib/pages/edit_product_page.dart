import 'package:flutter/material.dart';

import '../provider/model_product.dart';

class EditProductPage extends StatefulWidget {
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _imgUrlcontroller = TextEditingController();
  final _imgUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: DateTime.now().toString(),
    title: '',
    desc: '',
    price: 0,
    imgURL: '',
  );

  @override
  void initState() {
    _imgUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
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
    print(_editedProduct.title);
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
                  decoration: const InputDecoration(
                    label: Text('Description'),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  validator: (value) {
                    if (value!.length < 20)
                      return 'Description should be at leaset 20 charecters long';
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
                                fit: BoxFit.cover,
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