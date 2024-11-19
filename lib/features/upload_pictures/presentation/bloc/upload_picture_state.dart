import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class UploadPictureState extends Equatable {
  const UploadPictureState({
    this.imageBytes,
    this.formatChoosen,
  });

  final Uint8List? imageBytes;
  final String? formatChoosen;

  UploadPictureState copyWith({
    Uint8List? imageBytes,
    String? formatChoosen,
  }) {
    return UploadPictureState(
      imageBytes: imageBytes ?? this.imageBytes,
      formatChoosen: formatChoosen ?? this.formatChoosen,
    );
  }

  @override
  List<Object?> get props => [
        imageBytes,
        formatChoosen,
      ];
}
