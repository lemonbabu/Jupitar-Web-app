const String tablelink='tbl_link';
const String tablelinkid='id';
const String tablelinkname='name';
const String tablelinkaddress='adress';


class AddLinkModel{
  int? id;
  String link_name;
  String? link_address;

  AddLinkModel(
      {this.id,
        required this.link_name,
        this.link_address,
        });

  Map<String,dynamic> toMap(){
    var map=<String,dynamic>{
      tablelinkname:link_name,
      tablelinkaddress:link_address,
    };
    if(id!=null){
      map[tablelinkid]=id;
    }
    return map;
  }
  factory AddLinkModel.fromMap(Map<String, dynamic> map) => AddLinkModel(
    id: map[tablelinkid],
    link_name: map[tablelinkname],
    link_address: map[tablelinkaddress],
  );
}