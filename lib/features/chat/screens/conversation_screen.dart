import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/common/basewidgets/custom_loader_widget.dart';
import 'package:sixvalley_delivery_boy/common/basewidgets/paginated_list_view_widget.dart';
import 'package:sixvalley_delivery_boy/features/chat/controllers/chat_controller.dart';
import 'package:sixvalley_delivery_boy/features/dashboard/screens/dashboard_screen.dart';
import 'package:sixvalley_delivery_boy/features/profile/controllers/profile_controller.dart';
import 'package:sixvalley_delivery_boy/features/chat/domain/models/chat_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/common/basewidgets/custom_app_bar_widget.dart';
import 'package:sixvalley_delivery_boy/common/basewidgets/no_data_screen_widget.dart';
import 'package:sixvalley_delivery_boy/features/chat/widgets/chat_header_widget.dart';
import 'package:sixvalley_delivery_boy/features/chat/widgets/conversation_item_card_widget.dart';
import 'package:sixvalley_delivery_boy/features/profile/widgets/profile_info_widget.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';

class ConversationScreen extends StatefulWidget {
  final bool fromNotification;
  final int? chatIndex;
  const ConversationScreen({Key? key, required this.fromNotification, this.chatIndex}) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<ChatController>().setUserTypeIndex(widget.chatIndex ?? 0, isUpdate: false);
    Get.find<ChatController>().getConversationList(1, isUpdate: false);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if(widget.fromNotification) {
          Get.to(()=> const DashboardScreen(pageIndex: 0));
        }
        return;
      },
      child: Scaffold(resizeToAvoidBottomInset: false,
        appBar: CustomAppBarWidget(title: 'chatting'.tr, isSwitch: true,),
        body: GetBuilder<ChatController>(builder: (chatController) {

          ChatModel? _conversation;
          if(chatController.conversationModel != null) {
            _conversation = chatController.conversationModel;
          }

          return Column(children: [

            Container(height: 180,decoration: BoxDecoration(color: Theme.of(context).primaryColor.withValues(alpha:.9),
              borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(Dimensions.paddingSizeOverLarge),
                bottomRight: Radius.circular(Dimensions.paddingSizeOverLarge))),
              padding:  EdgeInsets.symmetric(vertical:Dimensions.paddingSizeExtraSmall),
              child:  Column(children:  [
                GetBuilder<ProfileController>(
                  builder: (profileController) => ProfileInfoWidget(profileModel: profileController.profileModel, isChat: true)),
                const ChatHeaderWidget()])),

             SizedBox(height:  Dimensions.paddingSizeSmall),

            // Text("WidgetChantIndex==>${widget.chatIndex}"),

            (chatController.conversationModel != null && !chatController.isLoading) ? chatController.conversationModel!.chat!.isNotEmpty ?
            Expanded(child:  RefreshIndicator(
                onRefresh: () async => chatController.getConversationList(1),
                child: Scrollbar(child: SingleChildScrollView(controller: _scrollController,
                    child: Center(child: SizedBox(width: 1170,
                        child:  Padding(padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                          child: PaginatedListViewWidget(
                            reverse: false,
                            scrollController: _scrollController,
                            onPaginate: (int? offset) => chatController.getConversationList(offset!),
                            totalSize: _conversation!.totalSize,
                            offset: int.parse(_conversation.offset!),
                            enabledPagination: chatController.conversationModel == null,
                            itemView: ListView.builder(
                              itemCount: _conversation.chat!.length,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => ConversationItemCardWidget(chat: _conversation!.chat![index]))))))))),
            ) : Padding(
              padding: EdgeInsets.only(top: Dimensions.menuProfileImageSize),
              child: NoDataScreenWidget(noDataImage: Images.noMessageFound, noDataMessage: chatController.isSearching ? 'no_conversation_found'.tr : 'no_message_found'.tr,),
            ) : CustomLoaderWidget(height: Get.height-500),
          ]);
        }),
      ),
    );
  }
}
