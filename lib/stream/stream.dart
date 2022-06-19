class ProductsStream {
  var id;
  String Pid;
  String title;
  String description;
  String owner;
  String city;
  String image;
  double price;


  ProductsStream({
    required this.Pid,
    required this.id,
    required this.title,
    required this.description,
    required this.owner,
    required this.city,
    required this.price,
    required this.image,
  });

  factory ProductsStream.fromJson(Map<String, dynamic> map) {
    return ProductsStream(
      id: map['id'],
      Pid: map['Pid'],
      title: map['title'],
      description: map['description'],
      owner: map['owner'],
      city: map['city'],
      image: map['image'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'Pid':Pid,
    'title': title,
    'description': description,
    'owner': owner,
    'city': city,
    'price': price,
    'image':image,
  };
}



class OrdersStream {
  var id;
  String Oid;
  String name;
  String seller;
  String buyer;
  String image;
  bool sended;
  double price;


  OrdersStream({
    required this.Oid,
    required this.id,
    required this.name,
    required this.seller,
    required this.buyer,
    required this.image,
    required this.sended,
    required this.price,
  });

  factory OrdersStream.fromJson(Map<String, dynamic> map) {
    return OrdersStream(
      Oid: map["Oid"],
      id:map["id"],
      sended: map['sended'],
      name: map['name'],
      seller: map['seller'],
      buyer: map['buyer'],
      image: map['image'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toJson() => {
    "Oid":Oid,
    'id':id,
    'name': name,
    'sended':sended,
    'seller': seller,
    'buyer': buyer,
    'price': price,
    'image':image,
  };
}