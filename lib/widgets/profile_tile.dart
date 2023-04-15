import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

class ProfileTile extends StatefulWidget {
  final String title;
  final String icon;
  final VoidCallback ontap;

  final bool islogout, isline, isswitch;
  ProfileTile(
      {Key? key,
      this.title = '',
      this.islogout = false,
      this.isswitch = false,
      this.isline = true,
      required this.icon,
      required this.ontap})
      : super(key: key);

  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  var switchvalue = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.sp),
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            onTap: widget.ontap,
            title: Txt(
              text: widget.title,
              fsize: 12,
              color: widget.islogout ? Colors.red : Colors.black,
            ),
            leading: CircleAvatar(
              radius: 16.sp,
              backgroundColor: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(widget.icon),
              ),
            ),
            trailing: widget.isswitch
                ? CupertinoSwitch(
                    value: switchvalue,
                    onChanged: (value) {
                      setState(() {
                        switchvalue = value;
                      });
                    },
                    activeColor: Colors.green,
                  )
                : SizedBox(),
          ),
        ),
        if (widget.isline)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.sp),
            child: Container(
              color: Colors.grey,
              height: 0.4,
            ),
          )
      ],
    );
  }
}
