import 'package:sixvalley_delivery_boy/features/order/domain/models/order_model.dart';
import 'package:sixvalley_delivery_boy/features/order/domain/models/product_model.dart';

class OrderDetailsModel {
  int?_shippingCostOrder;
  String?_serviceFeeOrder;
  int? _id;
  int? _orderId;
  int? _productId;
  int? _sellerId;
  Product? _productDetails;
  int? _qty;
  double? _price;
  double? _tax;
  double? _discount;
  String? _deliveryStatus;
  String? _paymentStatus;
  String? _createdAt;
  String? _updatedAt;
  int? _shippingMethodId;
  String? _variant;
  OrderModel? _orderModel;

  OrderDetailsModel({
    int?shippingCostOrder,
    String? serviceFeeOrder,
    int? id,
    int? orderId,
    int? productId,
    int? sellerId,
    Product? productDetails,
    int? qty,
    double? price,
    double? tax,
    double? discount,
    String? deliveryStatus,
    String? paymentStatus,
    String? createdAt,
    String? updatedAt,
    int? shippingMethodId,
    String? variant,
    OrderModel? orderModel,
  }) {
    _shippingCostOrder=shippingCostOrder;
    _serviceFeeOrder=serviceFeeOrder;
    _id = id;
    _orderId = orderId;
    _productId = productId;
    _sellerId = sellerId;
    _productDetails = productDetails;
    _qty = qty;
    _price = price;
    _tax = tax;
    _discount = discount;
    _deliveryStatus = deliveryStatus;
    _paymentStatus = paymentStatus;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _shippingMethodId = shippingMethodId;
    _variant = variant;
    _orderModel = orderModel;
  }
  int? get shippingCostOrder =>_shippingCostOrder;
  String? get serviceFeeOrder => _serviceFeeOrder;
  int? get id => _id;
  int? get orderId => _orderId;
  int? get productId => _productId;
  int? get sellerId => _sellerId;
  Product? get productDetails => _productDetails;
  int? get qty => _qty;
  double? get price => _price;
  double? get tax => _tax;
  double? get discount => _discount;
  String? get deliveryStatus => _deliveryStatus;
  String? get paymentStatus => _paymentStatus;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get shippingMethodId => _shippingMethodId;
  String? get variant => _variant;
  OrderModel? get orderModel => _orderModel;

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    _shippingCostOrder=json['shipping_cost_order'];
    _serviceFeeOrder=json['service_fee_order'];
    _id = json['id'];
    _orderId = json['order_id'];
    _productId = json['product_id'];
    _sellerId = json['seller_id'];
    if (json['product_details'] != null) {
      _productDetails = Product.fromJson(json['product_details']);
    }
    _qty = json['qty'];

    if (json['price'] != null) {
      _price = (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : json['price'];
    }

    if (json['tax'] != null) {
      _tax = (json['tax'] is int) ? (json['tax'] as int).toDouble() : json['tax'];
    }

    if (json['discount'] != null) {
      _discount = (json['discount'] is int)
          ? (json['discount'] as int).toDouble()
          : json['discount'];
    }

    _deliveryStatus = json['delivery_status'];
    _paymentStatus = json['payment_status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _shippingMethodId = json['shipping_method_id'];
    _variant = json['variant'];

    if (json['order'] != null) {
      _orderModel = OrderModel.fromJson(json['order']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shipping_cost_order']=_shippingCostOrder;
    data['service_fee_order']=_serviceFeeOrder;
    data['id'] = _id;
    data['order_id'] = _orderId;
    data['product_id'] = _productId;
    data['seller_id'] = _sellerId;
    if (_productDetails != null) {
      data['product_details'] = _productDetails!.toJson();
    }
    data['qty'] = _qty;
    data['price'] = _price;
    data['tax'] = _tax;
    data['discount'] = _discount;
    data['delivery_status'] = _deliveryStatus;
    data['payment_status'] = _paymentStatus;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['shipping_method_id'] = _shippingMethodId;
    data['variant'] = _variant;
    if (_orderModel != null) {
      data['order'] = _orderModel!.toJson();
    }
    return data;
  }

  static List<OrderDetailsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => OrderDetailsModel.fromJson(json)).toList();
  }
}
