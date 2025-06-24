class NotificationModel {
  int? totalSize;
  String? limit;
  String? offset;
  List<Notifications>? notifications;

  NotificationModel({this.totalSize, this.limit, this.offset, this.notifications});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int? id;
  int? deliveryManId;
  int? orderId;
  String? description;
  String? createdAt;
  String? updatedAt;
  Order? order;

  Notifications({
    this.id,
    this.deliveryManId,
    this.orderId,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.order,
  });

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryManId = int.tryParse(json['delivery_man_id'].toString());
    orderId = int.tryParse(json['order_id'].toString());
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['delivery_man_id'] = deliveryManId;
    data['order_id'] = orderId;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    return data;
  }
}

class Order {
  int? id;
  int? customerId;
  bool? isGuest;
  String? customerType;
  String? paymentStatus;
  String? orderStatus;
  String? paymentMethod;
  String? paymentNote;
  double? orderAmount;
  double? paidAmount;
  String? adminCommission;
  bool? isPause;
  String? cause;
  String? shippingAddress;
  String? createdAt;
  String? updatedAt;
  String? couponCode;
  String? couponDiscountBearer;
  String? shippingResponsibility;
  int? shippingMethodId;
  double? shippingCost;
  bool? isShippingFree;
  String? orderGroupId;
  String? verificationCode;
  bool? verificationStatus;
  int? sellerId;
  String? sellerIs;
  AddressData? shippingAddressData;
  int? deliveryManId;
  double? deliverymanCharge;
  String? expectedDeliveryDate;
  int? billingAddress;
  AddressData? billingAddressData;
  String? orderType;
  String? deliveryType;
  String? selectedDeliveryTime;
  String? deliveryDate;
  String? serviceFee;

  Order({
    this.id,
    this.customerId,
    this.isGuest,
    this.customerType,
    this.paymentStatus,
    this.orderStatus,
    this.paymentMethod,
    this.paymentNote,
    this.orderAmount,
    this.paidAmount,
    this.adminCommission,
    this.isPause,
    this.cause,
    this.shippingAddress,
    this.createdAt,
    this.updatedAt,
    this.couponCode,
    this.couponDiscountBearer,
    this.shippingResponsibility,
    this.shippingMethodId,
    this.shippingCost,
    this.isShippingFree,
    this.orderGroupId,
    this.verificationCode,
    this.verificationStatus,
    this.sellerId,
    this.sellerIs,
    this.shippingAddressData,
    this.deliveryManId,
    this.deliverymanCharge,
    this.expectedDeliveryDate,
    this.billingAddress,
    this.billingAddressData,
    this.orderType,
    this.deliveryType,
    this.selectedDeliveryTime,
    this.deliveryDate,
    this.serviceFee,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    isGuest = json['is_guest'];
    customerType = json['customer_type'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    paymentNote = json['payment_note'];
    orderAmount = (json['order_amount'] ?? 0).toDouble();
    paidAmount = (json['paid_amount'] ?? 0).toDouble();
    adminCommission = json['admin_commission'];
    isPause = json['is_pause'];
    cause = json['cause'];
    shippingAddress = json['shipping_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    couponCode = json['coupon_code'];
    couponDiscountBearer = json['coupon_discount_bearer'];
    shippingResponsibility = json['shipping_responsibility'];
    shippingMethodId = json['shipping_method_id'];
    shippingCost = (json['shipping_cost'] ?? 0).toDouble();
    isShippingFree = json['is_shipping_free'];
    orderGroupId = json['order_group_id'];
    verificationCode = json['verification_code'];
    verificationStatus = json['verification_status'];
    sellerId = json['seller_id'];
    sellerIs = json['seller_is'];
    shippingAddressData = json['shipping_address_data'] != null
        ? AddressData.fromJson(json['shipping_address_data'])
        : null;
    deliveryManId = json['delivery_man_id'];
    deliverymanCharge = (json['deliveryman_charge'] ?? 0).toDouble();
    expectedDeliveryDate = json['expected_delivery_date'];
    billingAddress = json['billing_address'];
    billingAddressData = json['billing_address_data'] != null
        ? AddressData.fromJson(json['billing_address_data'])
        : null;
    orderType = json['order_type'];
    deliveryType = json['delivery_type'];
    selectedDeliveryTime = json['selected_delivery_time'];
    deliveryDate = json['delivery_date'];
    serviceFee = json['service_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['is_guest'] = isGuest;
    data['customer_type'] = customerType;
    data['payment_status'] = paymentStatus;
    data['order_status'] = orderStatus;
    data['payment_method'] = paymentMethod;
    data['payment_note'] = paymentNote;
    data['order_amount'] = orderAmount;
    data['paid_amount'] = paidAmount;
    data['admin_commission'] = adminCommission;
    data['is_pause'] = isPause;
    data['cause'] = cause;
    data['shipping_address'] = shippingAddress;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['coupon_code'] = couponCode;
    data['coupon_discount_bearer'] = couponDiscountBearer;
    data['shipping_responsibility'] = shippingResponsibility;
    data['shipping_method_id'] = shippingMethodId;
    data['shipping_cost'] = shippingCost;
    data['is_shipping_free'] = isShippingFree;
    data['order_group_id'] = orderGroupId;
    data['verification_code'] = verificationCode;
    data['verification_status'] = verificationStatus;
    data['seller_id'] = sellerId;
    data['seller_is'] = sellerIs;
    if (shippingAddressData != null) {
      data['shipping_address_data'] = shippingAddressData!.toJson();
    }
    data['delivery_man_id'] = deliveryManId;
    data['deliveryman_charge'] = deliverymanCharge;
    data['expected_delivery_date'] = expectedDeliveryDate;
    data['billing_address'] = billingAddress;
    if (billingAddressData != null) {
      data['billing_address_data'] = billingAddressData!.toJson();
    }
    data['order_type'] = orderType;
    data['delivery_type'] = deliveryType;
    data['selected_delivery_time'] = selectedDeliveryTime;
    data['delivery_date'] = deliveryDate;
    data['service_fee'] = serviceFee;
    return data;
  }
}

class AddressData {
  int? id;
  String? contactPersonName;
  String? address;
  String? city;
  String? phone;
  String? latitude;
  String? longitude;

  AddressData({
    this.id,
    this.contactPersonName,
    this.address,
    this.city,
    this.phone,
    this.latitude,
    this.longitude,
  });

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactPersonName = json['contact_person_name'];
    address = json['address'];
    city = json['city'];
    phone = json['phone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['contact_person_name'] = contactPersonName;
    data['address'] = address;
    data['city'] = city;
    data['phone'] = phone;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
