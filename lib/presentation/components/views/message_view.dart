import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:withtalk_mobile/data/models/forum_answer.dart';
import 'package:withtalk_mobile/data/models/forum_message.dart';
import 'package:withtalk_mobile/presentation/components/views/user_avatar.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_theme.dart';
import '../app_network_image.dart';
import '../app_text.dart';

class MessageView extends StatefulWidget {
  const MessageView(
      {super.key,
      required this.messageModel,
      required this.onDissmis,
      required this.delete,
      required this.edit});
  final ForumMessageModel? messageModel;
  final Function(ForumMessageModel? messageModel) onDissmis;
  final Function(ForumMessageModel? messageModel) delete;
  final Function(ForumMessageModel? messageModel) edit;

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    if (!(widget.messageModel?.my ?? false)) {
      return _otherMessage();
    }

    return _myMessage();
  }

  Widget _myMessage() {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            const SizedBox(
              width: 50,
            ),
            Expanded(
              child: Column(
                children: [
                  Slidable(
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          borderRadius: BorderRadius.circular(20),
                          onPressed: (_) {
                            widget.edit(widget.messageModel);
                          },
                          icon: Icons.edit_note_sharp,
                          backgroundColor: Colors.green.withOpacity(0.3),
                        ),
                        SlidableAction(
                          borderRadius: BorderRadius.circular(20),
                          onPressed: (_) {
                            widget.delete(widget.messageModel);
                          },
                          icon: Icons.delete,
                          backgroundColor: Colors.red.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          _hasAnswer(widget.messageModel?.answer),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: AppText(
                              widget.messageModel?.text,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: AppText(
                      widget.messageModel?.date?.substring(0, 16),
                      color: AppTheme.grey1(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _otherMessage() {
    return SlidableAutoCloseBehavior(
      closeWhenOpened: true,
      closeWhenTapped: true,
      child: Slidable(
        key: UniqueKey(),
        endActionPane: ActionPane(
          dismissible: DismissiblePane(
            onDismissed: () {},
            confirmDismiss: () async {
              widget.onDissmis(widget.messageModel);
              return true;
            },
          ),
          motion: const ScrollMotion(),
          children: [],
        ),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (widget.messageModel?.user?.userPhoto == null)
                UserAvatar(
                  size: 40,
                )
              else
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(113),
                    child: AppNetworkImage(
                      wight: 40,
                      height: 40,
                      url: widget.messageModel?.user?.userPhoto,
                    ),
                  ),
                ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        color: AppTheme.backColor(context),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: AppText(
                              widget.messageModel?.user?.name,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _hasAnswer(widget.messageModel?.answer),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: AppText(
                              widget.messageModel?.text,
                              color: AppTheme.oppositePrimaryColor(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: AppText(
                        widget.messageModel?.date?.substring(0, 16),
                        color: AppTheme.grey1(context),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _hasAnswer(ForumAnswer? answer) {
    if (answer == null) {
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.primaryColor1,
                borderRadius: BorderRadius.circular(242)),
            height: 40,
            width: 2,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: AppText(
              _logicText(answer.text ?? ""),
              color: AppTheme.oppositePrimaryColor(context),
            ),
          )
        ],
      ),
    );
  }

  String? _logicText(String? text) {
    if ((text?.length ?? 0) < 41) return text;
    return "${text?.substring(0, 40)} . . .";
  }
}
