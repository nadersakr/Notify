import 'package:flutter/material.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/presentaion/widget/channel_container.dart';
import 'package:notify/shared/presentation/widgets/border_container.dart';

class ContainerChannelVertical extends StatelessWidget {
  const ContainerChannelVertical({
    super.key,
    required this.channelList,
    required this.letterSpace,
    required this.onTap,
    required this.height,
  });
  final void Function(Channel channel) onTap;
  final double? letterSpace;
  final double? height;
  final List<Channel> channelList;

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      child: Column(
        children: channelList.length > 4
            ? List.generate(4, (index) {
                final Channel channel = channelList[index];
                return GestureDetector(
                  onTap: () {
                    onTap(channel);
                  },
                  child: ChannelOverviewContainer(
                      height: height,
                      letterSpace: letterSpace,
                      channel: channel),
                );
              })
            : List.generate(channelList.length, (index) {
                final Channel channel = channelList[index];
                return GestureDetector(
                  onTap: () {
                    onTap(channel);
                  },
                  child: ChannelOverviewContainer(
                      height: height,
                      letterSpace: letterSpace,
                      channel: channel),
                );
              }),
      ),
    );
  }
}
