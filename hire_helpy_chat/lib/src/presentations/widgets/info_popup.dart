part of 'widgets.dart';

class InfoPopup extends StatelessWidget {
  const InfoPopup(
      {super.key,  this.title, this.message, required this.type});
  final String? title;
  final String? message;
  final String type;

  @override
  Widget build(BuildContext context) {
    return _getSuccessContainer(context);
  }

  _getSuccessContainer(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: type != 'success' ? const EdgeInsets.only(right: 40) : EdgeInsets.zero,
                  child: SizedBox(
                    width: 50,
                    child: Icon(
                       _getIcon(),
                      size: 50,
                      color: _getColor(),
                    ),
                  ),
                ),
              ],
            ),
            if (title != null)

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                title ?? '',
                style: TextStyle(
                    color: AppColors.black.withOpacity(0.5),
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            if (message != null)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  message ?? '',
                  style: const TextStyle(
                    color: AppColors.primaryGrey,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      );

  _getColor() {
    switch (type) {
      case 'success':
        return AppColors.secondaryColor;
      case 'info':
        return AppColors.primaryColor;
      
      case 'error':
        return AppColors.red;
    }
  }
  
  _getIcon() {
    
    switch (type) {
      case 'success':
        return Iconsax.tick_circle;

      case 'info':
        return Iconsax.warning_25;
      
      case 'error':
        return Iconsax.warning_25;
    }
  }
}
