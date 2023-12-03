import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cake_collection.dart';
import 'auth.dart';

class EditCake extends StatefulWidget {
  static const routeName = '/EditCake';

  @override
  _EditCakeState createState() => _EditCakeState();
}

class _EditCakeState extends State<EditCake> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final cakeProvider = Provider.of<CakeList>(context, listen: false);

    final selectedCakeId = ModalRoute.of(context)?.settings.arguments as String?;


    void _saveForm() async {
      final isValid = _formKey.currentState?.validate() ?? false;
      if (!isValid) {
        return;
      }

      // Mengambil nilai dari controller
      final name = _nameController.text;
      final description = _descriptionController.text;
      final price = double.parse(_priceController.text);
      final imageUrl = _imageUrlController.text;

      // Membuat objek cake baru
      final newCake = Cake(
        id: DateTime.now().toString(),
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );


      //Tambah atau update data di Firestore
      if (selectedCakeId == null || selectedCakeId.isEmpty) {
        // Jika ID kosong, artinya cake baru
        await cakeProvider.addCake(newCake);
      } else {
        // Jika ID tidak kosong, artinya update cake yang sudah ada
        await cakeProvider.updateCake(selectedCakeId, newCake);
      }

      // Bersihkan controller
      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      _imageUrlController.clear();

      // Navigasi kembali
      Navigator.of(context).pop();
    }

    // Dapatkan selected cake details dari Firestore dan set ke dalam controllers
    Future<void> _loadCakeDetails() async {
      if (selectedCakeId != null) {
        final firestoreService = FirebaseServiceCake();
        final selectedCake = await firestoreService.getCakeById(selectedCakeId);

        if (selectedCake != null) {
          _nameController.text = selectedCake.name;
          _descriptionController.text = selectedCake.description;
          _priceController.text = selectedCake.price.toString();
          _imageUrlController.text = selectedCake.imageUrl;
        }
      }
    }

    // Load cake details 
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCakeDetails();
    });





    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: const Text('Edit Cake'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama masih kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Harga',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga masih kosong';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Harga tidak valid';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Masukkan angka yang lebih besar dari 0';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi masih kosong';
                  }
                  if (value.length < 10) {
                    return 'Panjangnya minimal harus 10 karakter';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                ),
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL.';
                  }
                  if (!value.startsWith('http') && !value.startsWith('https')) {
                    return 'Please enter a valid URL.';
                  }
                  if (!value.endsWith('.png') &&
                      !value.endsWith('.jpg') &&
                      !value.endsWith('.jpeg')) {
                    return 'Please enter a valid image URL.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
