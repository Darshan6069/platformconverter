import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platformconvetor/modelclass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class platformProvider with ChangeNotifier {
  TextEditingController editName = TextEditingController();
  TextEditingController editNumber = TextEditingController();
  TextEditingController editChat = TextEditingController();
  File? editImage;
  var editDate;
  var editTime;
  int? editIndex;

  bool isPlatform = false;
  bool isTheme = false;
  bool proData = false;

  File? addImage;
  File? proImage;

  TextEditingController proNameController = TextEditingController();
  TextEditingController proBioController = TextEditingController();

  platformProvider() {
    proNameGetSharePrefrence();
    getProBioSharePrefrence();
    getImageSharePref();
  }

  getAlbumsImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      addImage = File(pickedFile.path);
    }
    notifyListeners();
  }

  getCameraImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      addImage = File(pickedFile.path);
    }
    notifyListeners();
  }

  profileAlbumsImage() async {
    var proFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (proFile != null) {
      proImage = File(proFile.path);
    }
    notifyListeners();
  }

  profileCameraImage() async {
    var proFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (proFile != null) {
      proImage = File(proFile.path);
    }
    notifyListeners();
  }

  editAlbumImage() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      editImage = File(pickedFile.path);
    }
    notifyListeners();
  }

  editCamera() async {
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      editImage = File(pickedFile.path);
    }
    notifyListeners();
  }

  List<ModelClass> contactData = [];

  //for PlatForm--------------------------------------------------
  set setPlatform(value) {
    isPlatform = value;
    notifyListeners();
  }

  get getPlatform {
    return isPlatform;
  }

  //for thmeme-----------------------------------------------------------
  set setTheme(value) {
    isTheme = value;
    notifyListeners();
  }

  get getTheme {
    return isTheme;
  }

  //for profile Data
//for thmeme-----------------------------------------------------------
  set setProfile(value) {
    proData = value;
    notifyListeners();
  }

  get getProfile {
    return proData;
  }

  addContactData(ModelClass Data) {
    contactData.add(Data);
    notifyListeners();
  }

  editContactData(ModelClass Data, index) {
    contactData[index] = (Data);
    notifyListeners();
  }

  deleteContactData(index) {
    contactData.removeAt(index);
    notifyListeners();
  }

//Name Store------------------------------------------------------
  proNameSetSharePrefrence(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('proName', value);
  }

  proNameGetSharePrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    proNameController.text = pref.getString('proName') ?? '';
  }

  //Bio Store------------------------------------------------------

  setProBioSharePrefrence(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('proBio', value);
  }

  getProBioSharePrefrence() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    proBioController.text = pref.getString('proBio') ?? '';
  }

  //Image Store------------------------------------------------------
  setImageSharePref(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('proImage', value);
  }

  getImageSharePref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    proImage = pref.getString('proImage') == null
        ? null
        : File((pref.getString('proImage'))!);
  }
}
