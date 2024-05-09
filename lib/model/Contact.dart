import 'package:firebase_database/firebase_database.dart';

class Contact {
  String? _id; // by firebase itself
  late String _firstName;
  late String _lastName;
  late String _phone;
  late String _email;
  late String _address;
  late String _photoUrl;

  Contact(this._firstName, this._lastName, this._phone, this._email,
      this._address, this._photoUrl);
  Contact.withId(this._id, this._firstName, this._lastName, this._phone,
      this._email, this._address, this._photoUrl);

  String? get id => this._id;
  String get firstName => this._firstName;
  String get lastName => this._lastName;
  String get phone => this._phone;
  String get email => this._email;
  String get address => this._address;
  String get photoUrl => this._photoUrl;

  set firstName(String firstName) {
    this._firstName = firstName;
  }

  set lastName(String lastName) {
    this._lastName = lastName;
  }

  set phone(String phone) {
    this._phone = phone;
  }

  set email(String email) {
    this._email = email;
  }

  set address(String address) {
    this._address = address;
  }

  set photoUrl(String photoUrl) {
    this._photoUrl = photoUrl;
  }

  // getters and setters are done
  // snapshot to project
  Contact.fromSnapshot(DataSnapshot snapshot) {
    //come all data from firebase as json
    Map<dynamic, dynamic> map = snapshot.value! as Map<dynamic, dynamic>;
    this._id = snapshot.key;
    this._firstName = map['firstName'];
    this._lastName = map['lastName'];
    this._phone = map['phone'];
    this._email = map['email'];
    this._address = map['address'];
    this._photoUrl = map['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': _firstName,
      'lastName': _lastName,
      'phone': _phone,
      'email': _email,
      'address': _address,
      'photoUrl': _photoUrl
    };
  }
}
