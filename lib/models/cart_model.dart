class CartModel {
  int? _id;
  String? _name;
  int? _price;
  String? _img;
  int? _quantity;
  bool? _isExit;
  String? _time;

  CartModel(
      {int? id,
        String? name,
        int? price,
        String? img,
        int? quantity,
        bool? isExit,
        String? time,
      }) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (price != null) {
      this._price = price;
    }
    if (img != null) {
      this._img = img;
    }
    if (quantity != null) {
      this._quantity = quantity;
    }
    if(isExit != null){
      this._isExit = isExit;
    }
    if(time != null){
      this._time = time;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  int? get price => _price;
  set price(int? price) => _price = price;
  String? get img => _img;
  set img(String? img) => _img = img;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;
  bool? get isExit => _isExit;
  set isExit(bool? isExit) => _isExit = isExit;
  String? get time => _time;
  set time(String? time) => _time = time;


  CartModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _img = json['img'];
    _quantity = json['quantity'];
    _isExit = json['isExit'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['price'] = this._price;
    data['img'] = this._img;
    data['quantity'] = this.quantity;
    data['isExit'] = this.isExit;
    data['time'] = this.time;
    return data;
  }
}
