import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/features/chat/domain/models/message_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MessageBubbleWidget extends StatelessWidget {
  final Message message;
  final Message? previous;
  final Message? next;

  const MessageBubbleWidget({
    Key? key,
    required this.message,
    this.previous,
    this.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSentByDeliveryMan = message.sentByDeliveryMan ?? false;

    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
      padding: EdgeInsets.only(
        left: isSentByDeliveryMan ? 50 : 10,
        right: isSentByDeliveryMan ? 10 : 50,
      ),
      alignment: isSentByDeliveryMan ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isSentByDeliveryMan ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [

          // Text message
          if (message.message != null && message.message!.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSentByDeliveryMan
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Theme.of(context).primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message.message!,
                style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
              ),
            ),

          // Attachments
          if (message.attachment != null && message.attachment!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: message.attachment!.map((attachment) {
                final url = attachment.path ?? '';
                final fileName = attachment.key ?? 'file';

                final isImage = (attachment.type == 'image') ||
                    url.toLowerCase().endsWith('.jpg') ||
                    url.toLowerCase().endsWith('.jpeg') ||
                    url.toLowerCase().endsWith('.png');

                final isPDF = (attachment.type == 'pdf') ||
                    url.toLowerCase().endsWith('.pdf');

                final isOther = !isImage && !isPDF;

                if (isImage) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        url,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 200,
                            height: 200,
                            color: Colors.grey.shade200,
                            alignment: Alignment.center,
                            child: const Text('📷 صورة غير صالحة'),
                          );
                        },
                      ),
                    ),
                  );
                } else if (isPDF) {
                  return InkWell(
                    onTap: () => launchUrlString(url),
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.picture_as_pdf, color: Colors.red),
                          const SizedBox(width: 10),
                          Text(
                            fileName,
                            style: rubikMedium.copyWith(color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () => launchUrlString(url),
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.insert_drive_file, color: Colors.blueGrey),
                          const SizedBox(width: 10),
                          Text(
                            fileName,
                            style: rubikMedium.copyWith(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  );
                }
              }).toList(),
            ),
        ],
      ),
    );
  }
}
