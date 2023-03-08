import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasir/common/shared_code.dart';
import 'package:kasir/repositories/customer/customer_repository.dart';
import 'package:kasir/widget/btn_primary.dart';
import 'package:kasir/widget/text_field_customer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nohpController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  File? _image;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1B9C42),
        elevation: 0,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CREATE CUSTOMER',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
            Text(
              'ini adalah halaman create customer',
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                SharedCode.addImage().then((value) {
                  setState(() {
                    _image = value;
                  });
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: _image == null
                    ? const Center(
                        child: Text('No image selected.'),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            TextFieldCustom(
              label: 'Nama',
              controller: _namaController,
            ),
            const SizedBox(height: 20),
            TextFieldCustom(
              label: 'No HP',
              controller: _nohpController,
            ),
            const SizedBox(height: 20),
            TextFieldCustom(
              label: 'Alamat',
              controller: _alamatController,
            ),
            const SizedBox(height: 30),
            BtnPrimary(
              txtBtn: 'Simpan',
              onPressed: () {
                context.loaderOverlay.show();
                CustomerRepository()
                    .createCustomer(
                        nama: _namaController.text,
                        nohp: _nohpController.text,
                        alamat: _alamatController.text,
                        photoKtp: _image!)
                    .then((value) => {
                          context.loaderOverlay.hide(),
                          if (value.meta!.code == 200)
                            {
                              Navigator.pop(context),
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(value.meta!.message!),
                                  backgroundColor: Colors.green,
                                ),
                              ),
                              setState(() {
                                _namaController.clear();
                                _nohpController.clear();
                                _alamatController.clear();
                                _image = null;
                              })
                            }
                          else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(value.meta!.message!),
                                  backgroundColor: Colors.red,
                                ),
                              ),
                              setState(() {
                                _namaController.clear();
                                _nohpController.clear();
                                _alamatController.clear();
                                _image = null;
                              })
                            }
                        });
              },
            ),
          ],
        ),
      ),
    );
  }
}
