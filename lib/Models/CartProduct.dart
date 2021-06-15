class CartProduct {
  var _color, _payment, _picture, _quantity, _size, _Name, _UID,_Id,_owner;

  CartProduct(this._color, this._payment, this._picture, this._quantity,
      this._size, this._Name, this._UID,this._Id,this._owner);

  factory CartProduct.fromJson(dynamic json) {
    return CartProduct(json['color'], json['payment'], json['picture'],
        json['quantity'], json['size'], json['name'], json['UID'],json['Id'],json['owner']);
  }

  Map<String, dynamic> toJson() => {
    'name': _Name,
    'color': _color,
    'payment': _payment,
    'picture': _picture,
    'quantity': _quantity,
    'size': _size,
    'UID': _UID,
    'Id' : _Id,
    'owner':_owner,
  };

  get UID => _UID;

  get name => _Name;

  get size => _size;

  get quantity => _quantity;

  get picture => _picture;

  get payment => _payment;

  get color => _color;

  get getowner => _owner;

  set owner(value) {
    _owner = value;
  }

  set setQuantity(value) {
    _quantity = value;
  }

  get Id => _Id;

  setOwner(value) {
    _owner = value;
  }
}
