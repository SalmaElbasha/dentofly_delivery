import 'dart:convert';

class OrderDetailsModel {
  final int? id;
  final int? orderId;
  final int? productId;
  final int? sellerId;
  final Product? productDetails;
  final int? qty;
  final double? price;
  final double? tax;
  final double? discount;
  final String? deliveryStatus;
  final String? paymentStatus;
  final String? createdAt;
  final String? updatedAt;
  final int? shippingMethodId;
  final String? variant;

  OrderDetailsModel({
    this.id,
    this.orderId,
    this.productId,
    this.sellerId,
    this.productDetails,
    this.qty,
    this.price,
    this.tax,
    this.discount,
    this.deliveryStatus,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.shippingMethodId,
    this.variant,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      id: json['id'] as int?,
      orderId: json['order_id'] as int?,
      productId: json['product_id'] as int?,
      sellerId: json['seller_id'] as int?,
      productDetails: json['product_details'] != null
          ? Product.fromJson(json['product_details'])
          : null,
      qty: json['qty'] as int?,
      price: _toDouble(json['price']),
      tax: _toDouble(json['tax']),
      discount: _toDouble(json['discount']),
      deliveryStatus: json['delivery_status'] as String?,
      paymentStatus: json['payment_status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      shippingMethodId: json['shipping_method_id'] as int?,
      variant: json['variant'] as String?,
    );
  }

  static List<OrderDetailsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => OrderDetailsModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value);
    return null;
  }
}

class Product {
  final int? id;
  final String? name;
  final int? categoryId;
  final double? unitPrice;
  final double? tax;
  final double? discount;
  final String? thumbnail;

  Product({
    this.id,
    this.name,
    this.categoryId,
    this.unitPrice,
    this.tax,
    this.discount,
    this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      name: json['name'] as String?,
      categoryId: json['category_id'] as int?,
      unitPrice: OrderDetailsModel._toDouble(json['unit_price']),
      tax: OrderDetailsModel._toDouble(json['tax']),
      discount: OrderDetailsModel._toDouble(json['discount']),
      thumbnail: json['thumbnail'] as String?,
    );
  }
}

void main() {
  String jsonResponse = '''[
    {
        "id": 10,
        "order_id": 100010,
        "product_id": 12,
        "seller_id": 3,
        "digital_file_after_sell": null,
        "product_details": {
            "id": 12,
            "added_by": "seller",
            "user_id": 3,
            "name": "test product",
            "slug": "test-product-EH7xZ3",
            "product_type": "physical",
            "category_ids": [
                {
                    "id": "99",
                    "position": 1
                }
            ],
            "category_id": 99,
            "sub_category_id": null,
            "sub_sub_category_id": null,
            "brand_id": 2,
            "unit": "kg",
            "min_qty": 1,
            "refundable": 1,
            "digital_product_type": null,
            "digital_file_ready": "",
            "digital_file_ready_storage_type": null,
            "images": [
                {
                    "image_name": "2025-05-03-6816345743918.webp",
                    "storage": "public"
                }
            ],
            "color_image": [],
            "thumbnail": "2025-05-03-6816345748b47.webp",
            "thumbnail_storage_type": "public",
            "preview_file": "",
            "preview_file_storage_type": "public",
            "featured": 0,
            "flash_deal": null,
            "video_provider": "youtube",
            "video_url": null,
            "colors": [],
            "variant_product": 0,
            "attributes": [],
            "choice_options": [],
            "variation": [],
            "digital_product_file_types": [],
            "digital_product_extensions": [],
            "published": 1,
            "unit_price": 300,
            "purchase_price": 0,
            "tax": 5,
            "tax_type": "percent",
            "tax_model": "include",
            "discount": 10,
            "discount_type": "flat",
            "current_stock": 300,
            "minimum_order_qty": 1,
            "details": "<p>dddfdfdfdf</p>",
            "free_shipping": 0,
            "attachment": null,
            "created_at": "2025-05-03T15:20:55.000000Z",
            "updated_at": "2025-05-03T15:32:34.000000Z",
            "status": 1,
            "featured_status": 1,
            "meta_title": "test product",
            "meta_description": "dddfdfdfdf",
            "meta_image": null,
            "request_status": 1,
            "denied_note": null,
            "shipping_cost": 0,
            "multiply_qty": 0,
            "temp_shipping_cost": null,
            "is_shipping_cost_updated": null,
            "code": "124578552",
            "preview_file_full_url": {
                "key": "",
                "path": null,
                "status": 404
            },
            "digital_file_ready_full_url": {
                "key": "",
                "path": null,
                "status": 404
            },
            "digital_variation": [],
            "clearance_sale": null,
            "thumbnail_full_url": {
                "key": "2025-05-03-6816345748b47.webp",
                "path": "https://dentofly.com/storage/app/public/product/thumbnail/2025-05-03-6816345748b47.webp",
                "status": 200
            },
            "colors_formatted": []
        },
        "qty": 1,
        "price": 285,
        "tax": 15,
        "discount": 10,
        "tax_model": "include",
        "delivery_status": "pending",
        "payment_status": "unpaid",
        "created_at": "2025-05-03T16:18:34.000000Z",
        "updated_at": "2025-05-03T16:18:34.000000Z",
        "shipping_method_id": null,
        "variant": "",
        "variation": [],
        "discount_type": "discount_on_product",
        "is_stock_decreased": 1,
        "refund_request": 0,
        "is_pause": false,
        "digital_file_after_sell_full_url": {
            "key": null,
            "path": null,
            "status": 404
        },
        "storage": [],
        "product_all_status": {}
    }
  ]''';

  List<dynamic> jsonList = jsonDecode(jsonResponse);
  List<OrderDetailsModel> orders = OrderDetailsModel.fromJsonList(jsonList);

  print('عدد العناصر: ${orders.length}');
  print('اسم المنتج أول عنصر: ${orders[0].productDetails?.name}');
  print('السعر: ${orders[0].price}');
}
