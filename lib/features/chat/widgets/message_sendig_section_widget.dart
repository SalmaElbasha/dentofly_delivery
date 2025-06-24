import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/features/chat/controllers/chat_controller.dart';
import 'package:sixvalley_delivery_boy/features/chat/widgets/custom_image_pick_bottom_sheet.dart';
import 'package:sixvalley_delivery_boy/helper/color_helper.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/common/basewidgets/custom_snackbar_widget.dart';
import 'package:flutter/foundation.dart' as foundation;

class MessageSendingSectionWidget extends StatefulWidget {
  final int? userId;
  const MessageSendingSectionWidget({Key? key, required this.userId}) : super(key: key);

  @override
  State<MessageSendingSectionWidget> createState() => _MessageSendingSectionWidgetState();
}

class _MessageSendingSectionWidgetState extends State<MessageSendingSectionWidget> {
  final TextEditingController _inputMessageController = TextEditingController();
  bool emojiPicker = false;

  bool _isMediaExist(ChatController chatController) {
    return (chatController.pickedMediaFileModelList?.isNotEmpty ?? false) ||
        (chatController.pickedFiles?.isNotEmpty ?? false);
  }

  bool _isMsgValid(ChatController chatController) {
    bool isImageMsgValid = (chatController.pickedMediaFileModelList?.isNotEmpty ?? false) && !chatController.pickedImageCrossMaxLength;
    bool isFileMsgValid = (chatController.pickedFiles?.isNotEmpty ?? false) && !chatController.pickedFIleCrossMaxLength;
    bool isTextMsgValid = _inputMessageController.text.trim().isNotEmpty &&
        !chatController.pickedImageCrossMaxLength &&
        !chatController.pickedFIleCrossMaxLength;
    return (isImageMsgValid || isFileMsgValid || isTextMsgValid) && !chatController.pickedFIleCrossMaxLimit;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (chatController) {
      return ColoredBox(
        color: _isMediaExist(chatController)
            ? Get.isDarkMode
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withOpacity(0.1)
            : Theme.of(context).primaryColor.withOpacity(0.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.paddingSizeDefault,
                  right: Dimensions.paddingSizeDefault,
                  bottom: Dimensions.paddingSizeDefault),
              child: Opacity(
                opacity: chatController.isSending ? 0.5 : 1,
                child: AbsorbPointer(
                  absorbing: chatController.isSending,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Get.isDarkMode
                                  ? Theme.of(context).hintColor.withOpacity(1)
                                  : Theme.of(context).primaryColor.withOpacity(0.5),
                              width: .75),
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        ),
                        child: TextField(
                          onTapOutside: (PointerDownEvent event) {
                            FocusScope.of(context).unfocus();
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(Dimensions.messageInputLength)
                          ],
                          controller: _inputMessageController,
                          onTap: () {
                            setState(() {
                              emojiPicker = false;
                            });
                          },
                          textCapitalization: TextCapitalization.sentences,
                          style: rubikRegular,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          minLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: Dimensions.paddingSizeLarge),
                            prefixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  emojiPicker = !emojiPicker;
                                  FocusScope.of(context).unfocus();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.iconSizeMedium),
                                child: Image.asset(Images.emoji, height: 24, width: 24),
                              ),
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () => chatController.pickOtherFile(false),
                                  child: Padding(
                                    padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                                    child: SizedBox(
                                        width: 24, child: Image.asset(Images.file)),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Get.bottomSheet(
                                    CustomImagePickBottomSheet(chatController),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                                    child: SizedBox(
                                      width: 24,
                                      child: Image.asset(Images.attachment,
                                          color: Get.isDarkMode
                                              ? ColorHelper.darken(
                                              Theme.of(context).primaryColor, 0.1)
                                              : Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            border: InputBorder.none,
                            hintText: 'type_here'.tr,
                            hintStyle: rubikRegular.copyWith(
                                color: Theme.of(context).hintColor,
                                fontSize: Dimensions.fontSizeLarge),
                          ),
                          onSubmitted: (String newText) {
                            if (newText.trim().isNotEmpty &&
                                !chatController.isSendButtonActive) {
                              chatController.toggleSendButtonActivity();
                            } else if (newText.isEmpty &&
                                chatController.isSendButtonActive) {
                              chatController.toggleSendButtonActivity();
                            }
                          },
                          onChanged: (String newText) {
                            if (newText.trim().isNotEmpty &&
                                !chatController.isSendButtonActive) {
                              chatController.toggleSendButtonActivity();
                            } else if (newText.isEmpty &&
                                chatController.isSendButtonActive) {
                              chatController.toggleSendButtonActivity();
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.paddingSizeSmall),
                    InkWell(
                      onTap: () async {
                        String messageText = _inputMessageController.text.trim();

                        if (messageText.isEmpty && _isMediaExist(chatController)) {
                          messageText = "."; // Placeholder to trigger attachment-only logic
                        }

                        if (_isMsgValid(chatController) || _isMediaExist(chatController)) {
                          String attachmentText = '';
                          if (_isMediaExist(chatController)) {
                            final List<String> mediaNames = [
                              ...?chatController.pickedMediaFileModelList
                                  ?.map((e) => e.file?.path.split('/').last ?? ""),
                              ...?chatController.pickedFiles
                                  ?.map((e) => e.path?.split('/').last ?? ""),
                            ];
                            attachmentText = mediaNames.join(', ');
                          }

                          String displayMessage;
                          if (messageText == "." && attachmentText.isNotEmpty) {
                            displayMessage = attachmentText;
                          } else if (attachmentText.isNotEmpty) {
                            displayMessage = "$messageText\n$attachmentText";
                          } else {
                            displayMessage = messageText;
                          }

                          await chatController
                              .sendMessage(displayMessage, widget.userId!)
                              .then((value) {
                            if (value.isSuccess) {
                              Future.delayed(const Duration(seconds: 2), () {
                                chatController.getChats(1, widget.userId);
                              });

                              _inputMessageController.clear();
                            }
                          });
                        } else {
                          if (chatController.pickedImageCrossMaxLength ||
                              chatController.pickedFIleCrossMaxLength ||
                              chatController.singleFIleCrossMaxLimit) {
                            showCustomSnackBarWidget(
                                '${"can_not_select_more_than".tr} ${AppConstants.maxLimitOfTotalFileSent.floor()} ${'files'.tr}');
                          } else {
                            showCustomSnackBarWidget('write_somethings'.tr);
                          }
                        }
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimensions.paddingSizeSmall),
                          border: Border.all(
                              color: Get.isDarkMode
                                  ? Theme.of(context).hintColor.withOpacity(1)
                                  : Theme.of(context).primaryColor.withOpacity(0.5),
                              width: .75),
                        ),
                        child: chatController.isSending
                            ? SizedBox(
                          width: 55,
                          height: 55,
                          child: Center(
                            child: SizedBox(
                              width: Dimensions.paddingSizeOverLarge,
                              height: Dimensions.paddingSizeOverLarge,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    Get.isLogEnable
                                        ? Theme.of(context)
                                        .hintColor
                                        .withOpacity(1)
                                        : Theme.of(context).primaryColor),
                                backgroundColor: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.5),
                              ),
                            ),
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.only(
                              left: 8, bottom: 8.0, right: 2, top: 2),
                          child: Image.asset(
                            Images.send,
                            width: 45,
                            height: 45,
                            color: Get.isDarkMode
                                ? Theme.of(context).hintColor.withOpacity(1)
                                : Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            if (emojiPicker)
              SizedBox(
                height: 250,
                child: EmojiPicker(
                  onBackspacePressed: () {},
                  textEditingController: _inputMessageController,
                  config: Config(
                    height: 256,
                    checkPlatformCompatibility: true,
                    emojiViewConfig: EmojiViewConfig(
                      emojiSizeMax: 28 *
                          (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.2 : 1.0),
                    ),
                    skinToneConfig: const SkinToneConfig(),
                    categoryViewConfig: const CategoryViewConfig(),
                    bottomActionBarConfig: const BottomActionBarConfig(),
                    searchViewConfig: const SearchViewConfig(),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
