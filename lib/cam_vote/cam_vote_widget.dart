import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:votingapp/core/extensions/app_theme_extensions.dart';
import 'package:votingapp/core/theme/colors.dart';
import 'package:votingapp/widget/bottom_sheet.dart';
import 'package:votingapp/widget/raised_button.dart';

class CamVoteWidget extends StatefulWidget {
  const CamVoteWidget({super.key, required this.name});
  final String name;
  @override
  State<CamVoteWidget> createState() => _CamVoteWidgetState();
}

class _CamVoteWidgetState extends State<CamVoteWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.name);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.chevron_left)),
        title: Center(
            child: Text(
          'Vote Now',
          style: context.textTheme.labelLarge
              ?.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
        )),
        actions: const [
          Gap(40),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            //for Favourite cricket star
            Container(
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.5,
                      child: Text(
                        'Vote for your favorite cricket star!',
                        style: context.textTheme.labelLarge?.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const Gap(10),
                    Text(
                      '5 mins ago',
                      style: context.textTheme.labelLarge
                          ?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    const Gap(20),
                    RaisedButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                            // isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return BottomSheetContent(
                                name: widget.name,
                                documentName: 'favPlayer',
                                label: 'Vote for your favorite cricket star!',
                              );
                            });
                      },
                      color: primaryColor,
                      label: 'Vote Now',
                    )
                  ],
                ),
              ),
            ),
            const Gap(12),
            //for Fan choice awards
            Container(
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.5,
                      child: Text(
                        'Fan choice awards: Top cricket player of the year',
                        style: context.textTheme.labelLarge?.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const Gap(10),
                    Text(
                      '10 mins ago',
                      style: context.textTheme.labelLarge
                          ?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    const Gap(20),
                    RaisedButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                            // isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return BottomSheetContent(
                                name: widget.name,
                                documentName: 'fanChoice',
                                label:
                                    'Fan choice awards: Top cricket player of the year',
                              );
                            });
                      },
                      color: primaryColor,
                      label: 'Vote Now',
                    )
                  ],
                ),
              ),
            ),
            const Gap(12),

            //for Favourite cricket hero
            Container(
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.5,
                      child: Text(
                        'Pick your cricket hero: Vote today',
                        style: context.textTheme.labelLarge?.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const Gap(10),
                    Text(
                      '5 mins ago',
                      style: context.textTheme.labelLarge
                          ?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    const Gap(20),
                    RaisedButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                            // isScrollControlled: true,

                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return BottomSheetContent(
                                name: widget.name,
                                documentName: 'cricketHero',
                                label: 'Pick your cricket hero: Vote today',
                              );
                            });
                      },
                      color: primaryColor,
                      label: 'Vote Now',
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
