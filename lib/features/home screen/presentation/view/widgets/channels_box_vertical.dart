import 'package:flutter/material.dart';
import 'package:notify/shared/domin/models/channel_model.dart';
import 'package:notify/shared/presentaion/widget/channel_container.dart';
import 'package:notify/shared/presentaion/widget/border_container.dart';

class ContainerChannelVertical extends StatelessWidget {
  const ContainerChannelVertical({
    super.key,
    required this.channelList,
    required this.letterSpace,
    required this.onTap,
    required this.height,
    this.maximumNumberOfChannels = 4,
  });
  final void Function(Channel channel) onTap;
  final double? letterSpace;
  final double? height;
  final int maximumNumberOfChannels;
  final List<Channel> channelList;

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      child: channelList.isNotEmpty
          ? Column(
              children: channelList.length > maximumNumberOfChannels
                  ? List.generate(maximumNumberOfChannels, (index) {
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
            )
          : const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: Text("No Channels Found")),
            ),
    );
  }
}
