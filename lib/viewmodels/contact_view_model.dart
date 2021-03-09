import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_contact_app/models/contact.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:faker/faker.dart';

class ContactViewModel extends ChangeNotifier {
  List<Contact> _contacts = new List<Contact>(12);
  int _length = 5;
  bool _lastContact = false;


  void generateRandomContact() {

    for (var i = 0; i < 12; i++) {
      var user = randUser();
      String phone = randPhone();
      DateTime checkin = randDate();
      _contacts[i]=Contact(user:user,phone:phone,checkin:checkin);
    }
    _contacts.sort((b,a) => a.checkin.compareTo(b.checkin));
    notifyListeners();
  }

  String randUser(){
    var _faker = new Faker();
    return _faker.person.name();
  }

  String randPhone(){
    const _chars = '1234567890';
    Random _rnd = Random();
    String _phone = String.fromCharCodes(Iterable.generate(8, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    return "01$_phone";
  }

  DateTime randDate(){
    Random _rnd = Random();
    int _mins = _rnd.nextInt(1000);
    return DateTime.now().subtract(new Duration(minutes: _mins));
  }

  String getUser(int index) {
    return _contacts[index].user;
  }

  String getPhone(int index) {
    return _contacts[index].phone;
  }

  String getCheckIn(int index) {
    return timeago.format(_contacts[index].checkin);
  }

  DateTime getDateTime(int index) {
    return _contacts[index].checkin;
  }

  bool getLastContact() {
    return _lastContact;
  }

  int getLength() {
    return _length;
  }

  Future<bool> addLength() async {
    int newLength = _length + 5;
    if (newLength > _contacts.length) {
      _length = _contacts.length;
      _lastContact = true;
    } else
      _length = newLength;
    await Future.delayed(Duration(seconds: 1));
    notifyListeners();
    return _lastContact;
  }
}
