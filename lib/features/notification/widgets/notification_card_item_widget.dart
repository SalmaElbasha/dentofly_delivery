import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/common/basewidgets/custom_asset_image_widget.dart';
import 'package:sixvalley_delivery_boy/features/notification/controllers/notification_controller.dart';
import 'package:sixvalley_delivery_boy/features/notification/domain/models/notifications_model.dart';
import 'package:sixvalley_delivery_boy/helper/date_converter.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';

import '../../order/controllers/order_controller.dart';
import '../../order/domain/models/order_model.dart';
import '../../order_details/controllers/order_details_controller.dart';
import '../../order_details/domain/models/order_details_model.dart';
import '../../order_details/screens/order_details_screen.dart';

class NotificationCardWidget extends StatefulWidget {
  final Notifications? notificationModel;
  final bool addTitle;
  final int index;
  const NotificationCardWidget({Key? key, this.notificationModel, this.addTitle = false, required this.index}) : super(key: key);

  @override
  State<NotificationCardWidget> createState() => _NotificationCardWidgetState();
}

class _NotificationCardWidgetState extends State<NotificationCardWidget> {
  OrderModel? orderModel;
  List<OrderDetailsModel>? orderDetailsList;
  Future<void> _loadData() async {
    await Get.find<OrderController>().getAllOrderHistory("", "", "", "", 0);
    orderModel=Get.find<OrderController>().allOrderHistory.firstWhereOrNull((order) => order.id == widget.notificationModel?.orderId);
  }
  @override
  void initState() {
    super.initState();
    _loadData().then((_) {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {


    return GetBuilder<NotificationController>(builder: (notificationController) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            if(_willShowDate(widget.index, notificationController.notificationModel!.notifications)) ...[

              SizedBox(height: Dimensions.rememberMeSizeDefault),

              Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.paddingSizeDefault,
                    bottom: Dimensions.paddingSizeExtraSmall
                ),
                child: Text(
                  DateConverter.getRelativeDateStatus(notificationController.notificationModel?.notifications?[widget.index].createdAt ?? '', context),
                  style: rubikRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha:0.70),
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
              SizedBox(height: Dimensions.paddingSizeMin),

            ],

            InkWell(
              onTap: ()async{


                Get.to(
                    ()=>OrderDetailsScreen(orderModel:  orderModel,fromNotification: true,)
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha:0.05),
                        spreadRadius: 0,
                        blurRadius: 7,
                        offset: const Offset(0, 1)
                    ),
                  ],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  widget.addTitle ?  Padding(padding: const EdgeInsets.all(10).copyWith(bottom: 0),
                    child: Text(DateConverter.dateTimeStringToDateOnly(widget.notificationModel!.createdAt!))) : const SizedBox(),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 45,
                      height: 45,
                      padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(color: Colors.black.withValues(alpha: 0.10), width: 1),
                      ),
                      child: const CustomAssetImageWidget(Images.deliveryNotificationIcon, width: double.infinity, height: double.infinity),
                    ),
                    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Expanded(child: Text('${'order'.tr} # ${widget.notificationModel!.orderId.toString()}', style: rubikMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Get.isDarkMode
                            ? Theme.of(context).hintColor.withValues(alpha:.7)
                            : null,
                      ))),
                      SizedBox(width: Dimensions.paddingSizeMin),

                      Text(DateConverter.getLocalTimeWithAMPM(widget.notificationModel?.createdAt ?? ''), style: rubikRegular.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: Theme.of(context).primaryColor,
                      )),

                    ]),
                    subtitle: Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMin),
                      child: Text(
                        widget.notificationModel!.description ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Get.isDarkMode ? Theme.of(context).hintColor.withValues(alpha:.7) : null),
                      ),
                    ),
                  ),

                ]),
              ),
            ),
          ],
        );
      }
    );
  }

  bool _willShowDate(int index, List<Notifications>? notificationList) {

    if (notificationList?.isEmpty ?? true) return false;
    if (index == 0) return true;


    final currentSupportTicket = notificationList?[index];
    final currentSupportTicketDate = DateTime.tryParse(currentSupportTicket?.createdAt ?? '');


    final previousSupportTicket = notificationList?[index - 1];
    final previousSupportTicketDate = DateTime.tryParse(previousSupportTicket?.createdAt ?? '');

    return currentSupportTicketDate?.day != previousSupportTicketDate?.day;
  }
}
