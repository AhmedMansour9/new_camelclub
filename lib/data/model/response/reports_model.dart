import 'dart:convert';
/// result : [{"id":2,"categoryComplanitId":2,"nameAr":"خلاط كهرباء","nameEn":"Electric mixer","descriptionAr":"خلاط كهرباء","descriptionEn":"Electric mixer"},{"id":4,"categoryComplanitId":2,"nameAr":"خلاط مطبخ","nameEn":"Kitchen mixer","descriptionAr":"id eiusmod conse","descriptionEn":"nulla consectetur"}]
/// pageIndex : 1
/// totalPages : 1
/// totalItems : 2
/// pageSize : 9
/// message : "CheckListModelComplanitRetrievedSuccessfully"
/// statusEnum : "success"


class ReportsModel {

 late int _id;
 late String _catId;
 late String _catName;
 late String? _note;
 late String? _image;
 late List<String> _checkListId;
 late List<String> _checkListTitle;

  ReportsModel({required int id,required String catId,required String catName, String? note, String?  image,
   required List<String> checkListIds,required List<String> checkListTitles}){
    _id=id;
    _catId=catId;
    _catName=catName;
    _note=note;
    _image=image;
    _checkListId=checkListIds;
    _checkListTitle=checkListTitles;

  }

 List<String> get checkListTitle => _checkListTitle;

  List<String> get checkListId => _checkListId;

  String? get image => _image;

  String? get note => _note;

  String get catName => _catName;

  String get catId => _catId;

  int get id => _id;

// String get id => _id;
  //
  // set id(String value) {
  //   _id = value;
  // }
  //
  // String get catId => _catId;
  //
  // set catId(String value) {
  //   _catId = value;
  // }
  //
  // String get name => _catName;
  //
  // set name(String value) {
  //   _catName = value;
  // }
  //
  // String? get note => _note;
  //
  // set note(String value) {
  //   _note = value;
  // }
  //
  // String? get image => _image;
  //
  // set image(String value) {
  //   _image = value;
  // }
}


