import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/features/splash/controllers/splash_controller.dart';

class PriceConverter {
  static String convertPrice(
      double? price, {
        double? discount,
        String? discountType,
        int asFixed = 2,
      }) {
    if (price == null) return '0.00';

    // Apply discount if provided
    if (discount != null && discountType != null) {
      if (discountType == 'amount') {
        price -= discount;
      } else if (discountType == 'percent') {
        price -= ((discount / 100) * price);
      }
    }

    final splashController = Get.find<SplashController>();
    final bool singleCurrency = splashController.configModel!.currencyModel == 'single_currency';
    final bool inRight = splashController.configModel!.currencySymbolPosition == 'right';
    final symbol = splashController.myCurrency?.symbol ?? '';
    final decimalPoints = (splashController.configModel!.decimalPointSetting ?? 2).clamp(2, 10);

    double finalPrice = singleCurrency
        ? price
        : price * splashController.myCurrency!.exchangeRate! *
        (1 / splashController.usdCurrency!.exchangeRate!);

    String formattedPrice = finalPrice
        .toStringAsFixed(asFixed > decimalPoints ? asFixed : decimalPoints)
        .replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );

    return '${inRight ? '' : symbol} $formattedPrice${inRight ? symbol : ''}';
  }

  static String convertPriceWithoutSymbol(
      BuildContext context,
      double? price, {
        double? discount,
        String? discountType,
        int asFixed = 2,
      }) {
    if (price == null) return '0.00';

    if (discount != null && discountType != null) {
      if (discountType == 'amount' || discountType == 'flat') {
        price -= discount;
      } else if (discountType == 'percent' || discountType == 'percentage') {
        price -= ((discount / 100) * price);
      }
    }

    final splashController = Get.find<SplashController>();
    final bool singleCurrency = splashController.configModel!.currencyModel == 'single_currency';
    final decimalPoints = (splashController.configModel!.decimalPointSettings ?? 2).clamp(2, 10);

    double finalPrice = singleCurrency
        ? price
        : price * splashController.myCurrency!.exchangeRate! *
        (1 / splashController.usdCurrency!.exchangeRate!);

    return finalPrice.toStringAsFixed(asFixed > decimalPoints ? asFixed : decimalPoints);
  }

  static double convertWithDiscount(double price, double discount, String discountType) {
    if (discountType == 'amount') {
      return price - discount;
    } else if (discountType == 'percent') {
      return price - ((discount / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double discount, String type, int quantity) {
    if (type == 'amount') {
      return discount * quantity;
    } else if (type == 'percent') {
      return (discount / 100) * (amount * quantity);
    }
    return 0.0;
  }

  static String percentageCalculation(String price, String discount, String discountType) {
    final symbol = Get.find<SplashController>().myCurrency?.symbol ?? '';
    return '$discount${discountType == 'percent' ? '%' : symbol} OFF';
  }
}
