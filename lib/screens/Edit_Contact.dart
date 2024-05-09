import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../model/Contact.dart';

class Edit_Contact extends StatefulWidget {
  // const Edit_Contact({Key? key}) : super(key: key);
  var id;
  Edit_Contact(this.id);
  @override
  State<Edit_Contact> createState() => _EditContactState(id);
}

class _EditContactState extends State<Edit_Contact> {
  final GlobalKey<FormState> _key = GlobalKey();
  _EditContactState(this.id);
  var id;
  String newfirstname = '';
  String newlastname = '';
  String newphone = '';
  String newmail = '';
  String newaddress = '';
  String newphotoUrl = '';
  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  late Contact _contact;
  @override
  void initState() {
    super.initState();
    getContact(id);
  }

  getContact(id) async {
    _databaseReference.child(id).onValue.listen((event) {
      setState(() {
        _contact = Contact.fromSnapshot(event.snapshot);
        newphotoUrl = _contact.photoUrl;
      });
    });
  }

  updatecontact() async {
    _contact = Contact.withId(
      id,
      this.newfirstname,
      this.newlastname,
      this.newphone,
      this.newmail,
      this.newaddress,
      this.newphotoUrl,
    );

    setState(() {
      _databaseReference.child(id).set(_contact);
      print("Profile updated Successfully");
    });
  }

  formsaved() async {
    print("Hello");
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      print("${this.newfirstname}Hellp");
      print(this.newlastname);

      // updatecontact();
    } else {
      print("Where r u ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit SCreen "),
        backgroundColor: Colors.amber,
      ),
      body: _contact == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      controller:
                          TextEditingController(text: _contact.firstName),
                      decoration: InputDecoration(
                        labelText: "Name",
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter the new First Name ";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Callback triggered when the text field's content changes
                        print('Current value: $value');
                      },
                      onSaved: (newValue) => newfirstname,
                    ),
                    TextFormField(
                      controller:
                          TextEditingController(text: _contact.lastName),
                      decoration: InputDecoration(
                        labelText: "Last Name",
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter the new Last Name ";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Callback triggered when the text field's content changes
                        print('Current value: $value');
                      },
                      onSaved: (newValue) => newlastname,
                    ),
                    TextFormField(
                      controller: TextEditingController(text: _contact.phone),
                      decoration: InputDecoration(
                        labelText: "Phone",
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter the new phone ";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Callback triggered when the text field's content changes
                        print('Current value: $value');
                      },
                      onSaved: (newValue) => newphone,
                    ),
                    TextFormField(
                      controller: TextEditingController(text: _contact.address),
                      decoration: InputDecoration(
                        labelText: "Address",
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter the new address ";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Callback triggered when the text field's content changes
                        print('Current value: $value');
                      },
                      onSaved: (newValue) => newaddress,
                    ),
                    TextFormField(
                      controller: TextEditingController(text: _contact.email),
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter the new email ";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Callback triggered when the text field's content changes
                        print('Current value: $value');
                      },
                      onSaved: (newValue) => newmail,
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          formsaved();
                          print("Form is saved ");
                        });
                        
                      },
                      child: Text("Save"),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
