part of 'widgets.dart';

class ToastMessage extends StatefulWidget {
  final String message;
  final String? desc;
  final Color color;
  const ToastMessage(
      {super.key,
      required this.message,
      this.desc,
      this.color = const Color(0xFF06B506)});

  @override
  State<ToastMessage> createState() => _ToastMessageState();
}

class _ToastMessageState extends State<ToastMessage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Positioned(
      top: height * 0.79,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: width,
          child: Center(
            child: Container(
              height: 76,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.message,
                    style: GoogleFonts.poppins(
                        color: widget.color,
                        fontSize: widget.message.length > 36 ? 12.0 : 15.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${widget.desc}",
                    style: GoogleFonts.poppins(
                        color: const Color(0xFFA8A6A6),
                        fontSize: widget.message.length > 36 ? 11 : 13.0,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
