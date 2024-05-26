import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as imglib;

final _orientations = {
  DeviceOrientation.portraitUp: 0,
  DeviceOrientation.landscapeLeft: 90,
  DeviceOrientation.portraitDown: 180,
  DeviceOrientation.landscapeRight: 270,
};

InputImage? inputImageFromCameraImage(CameraImage image,
    CameraDescription camera, CameraController cameraController) {
  // get image rotation
  // it is used in android to convert the InputImage from Dart to Java
  // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C
  // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas
  final sensorOrientation = camera.sensorOrientation;
  InputImageRotation? rotation;
  if (Platform.isIOS) {
    rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
  } else if (Platform.isAndroid) {
    var rotationCompensation =
        _orientations[cameraController.value.deviceOrientation];
    if (rotationCompensation == null) return null;
    if (camera.lensDirection == CameraLensDirection.front) {
      // front-facing
      rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
    } else {
      // back-facing
      rotationCompensation =
          (sensorOrientation - rotationCompensation + 360) % 360;
    }
    rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
  }
  if (rotation == null) return null;

  // get image format
  final format = InputImageFormatValue.fromRawValue(image.format.raw);
  // validate format depending on platform
  // only supported formats:
  // * nv21 for Android
  // * bgra8888 for iOS
  if (format == null ||
      (Platform.isAndroid && format != InputImageFormat.nv21) ||
      (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

  // since format is constraint to nv21 or bgra8888, both only have one plane
  if (image.planes.length != 1) return null;
  final plane = image.planes.first;

  // compose InputImage using bytes
  return InputImage.fromBytes(
    bytes: plane.bytes,
    metadata: InputImageMetadata(
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation, // used only in Android
      format: format, // used only in iOS
      bytesPerRow: plane.bytesPerRow, // used only in iOS
    ),
  );
}

imglib.Image? decodeYUV420SP(InputImage image) {
  try {
    final width = image.metadata!.size.width.toInt();
    final height = image.metadata!.size.height.toInt();

    Uint8List yuv420sp = image.bytes!;
    //int total = width * height;
    //Uint8List rgb = Uint8List(total);
    var outImg =
        imglib.Image(width: width, height: height); // default numChannels is 3

    final int frameSize = width * height;

    for (int j = 0, yp = 0; j < height; j++) {
      int uvp = frameSize + (j >> 1) * width, u = 0, v = 0;
      for (int i = 0; i < width; i++, yp++) {
        int y = (0xff & yuv420sp[yp]) - 16;
        if (y < 0) y = 0;
        if ((i & 1) == 0) {
          v = (0xff & yuv420sp[uvp++]) - 128;
          u = (0xff & yuv420sp[uvp++]) - 128;
        }
        int y1192 = 1192 * y;
        int r = (y1192 + 1634 * v);
        int g = (y1192 - 833 * v - 400 * u);
        int b = (y1192 + 2066 * u);

        if (r < 0) {
          r = 0;
        } else if (r > 262143) {
          r = 262143;
        }
        if (g < 0) {
          g = 0;
        } else if (g > 262143) {
          g = 262143;
        }
        if (b < 0) {
          b = 0;
        } else if (b > 262143) {
          b = 262143;
        }

        // outImg.setPixelRgb(i, j, ((r << 6) & 0xff0000) >> 16,
        //     ((g >> 2) & 0xff00) >> 8, b & 0xff);
        outImg.setPixelRgb(i, j, ((r << 6) & 0xff0000) >> 16,
            ((g >> 2) & 0xff00) >> 8, (b >> 10) & 0xff);

        /*rgb[yp] = 0xff000000 |
            ((r << 6) & 0xff0000) |
            ((g >> 2) & 0xff00) |
            ((b >> 10) & 0xff);*/
      }
    }

    //Rotate Image 90 degrees to right
    outImg = imglib.copyRotate(outImg, angle: 90);

    return outImg;
  } catch (e) {
    return null;
  }
}

class WorkPermitDetails {
  String? fin;
  DateTime? birthday;
  String? frontImagePath;
  String? frontImageThumbnail;
  String? backImagePath;
  String? backImageThumbnail;

  WorkPermitDetails({this.fin, this.birthday});

  mergeOtherDetails(WorkPermitDetails other, {bool? isFront}) {
    fin ??= other.fin;
    birthday ??= other.birthday;
    if (isFront != null) {
      if (isFront) {
        frontImagePath = other.frontImagePath;
        frontImageThumbnail = other.frontImageThumbnail;
        backImagePath ??= other.backImagePath;
        backImageThumbnail ??= other.backImageThumbnail;
      } else {
        backImagePath = other.backImagePath;
        backImageThumbnail = other.backImageThumbnail;
        frontImagePath ??= other.frontImagePath;
        frontImageThumbnail ??= other.frontImageThumbnail;
        fin = other.fin;
        birthday = other.birthday;
      }
    } else {
        backImagePath ??= other.backImagePath;
        backImageThumbnail ??= other.backImageThumbnail;
        frontImagePath ??= other.frontImagePath;
        frontImageThumbnail ??= other.frontImageThumbnail;
    }
  }
}
