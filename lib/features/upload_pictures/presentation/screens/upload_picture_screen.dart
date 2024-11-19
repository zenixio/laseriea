import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laseriea/features/upload_pictures/presentation/bloc/upload_picture_cubit.dart';
import 'package:laseriea/features/upload_pictures/presentation/bloc/upload_picture_state.dart';
import 'package:laseriea/utils/app_locale.dart';
import 'package:laseriea/utils/dialogs.dart';
import 'package:laseriea/utils/overlay_loader.dart';

import '../../../../utils/colors.dart';

class UploadPictureScreen extends StatelessWidget {
  const UploadPictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadPictureCubit()..loadFromStorage(),
      child: BlocBuilder<UploadPictureCubit, UploadPictureState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (state.imageBytes != null)
                Card(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.memory(
                      state.imageBytes!,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              else
                Text(
                  textAlign: TextAlign.center,
                  AppLocale.of(context)?.addPictureDesc ?? '',
                  style: const TextStyle(color: Colors.black),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (kIsWeb) {
                    context.read<UploadPictureCubit>().pickFile(
                      onSizeError: () {
                        showErrorDialog(context, message: AppLocale.of(context)?.fileTooLarge);
                      },
                      onError: () {
                        showErrorDialog(context);
                      },
                      onLoadingEntry: () {
                        OverlayLoaderManager.instance.showLoader(context);
                      },
                      onLoadingExit: () {
                        OverlayLoaderManager.instance.hideLoader();
                      },
                    );

                    return;
                  }

                  final cubit = BlocProvider.of<UploadPictureCubit>(context);
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (_) => BlocProvider.value(
                      value: cubit,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.camera, color: Dcolors.cyan),
                              title: Text(AppLocale.of(context)?.imagePickerCamera ?? ""),
                              onTap: () {
                                Navigator.of(context).pop();
                                context.read<UploadPictureCubit>().captureImageWithCamera(
                                  onError: () {
                                    showErrorDialog(context);
                                  },
                                  onLoadingEntry: () {
                                    OverlayLoaderManager.instance.showLoader(context);
                                  },
                                  onLoadingExit: () {
                                    OverlayLoaderManager.instance.hideLoader();
                                  },
                                );
                              },
                            ),
                            ListTile(
                              iconColor: Dcolors.blue,
                              leading: Icon(Icons.photo, color: Dcolors.teal),
                              title: Text(AppLocale.of(context)?.imagePickerGallery ?? ""),
                              onTap: () {
                                Navigator.of(context).pop();
                                _pickFromGallery(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Dcolors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                child: Text(
                  AppLocale.of(context)?.addPicture ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _pickFromGallery(BuildContext context) {
    context.read<UploadPictureCubit>().pickImageFromGallery(
      onSizeError: () {
        showErrorDialog(context, message: AppLocale.of(context)?.fileTooLarge);
      },
      onError: () {
        showErrorDialog(context);
      },
      onLoadingEntry: () {
        OverlayLoaderManager.instance.showLoader(context);
      },
      onLoadingExit: () {
        OverlayLoaderManager.instance.hideLoader();
      },
    );
  }
}
