import 'package:flutter/material.dart';
import 'package:laseriea/utils/colors.dart';

class OverlayLoaderManager {
  OverlayLoaderManager._();

  static final OverlayLoaderManager _singleton = OverlayLoaderManager._();

  static OverlayLoaderManager get instance => _singleton;

  bool isLoading = false;

  void showLoader(BuildContext context) {
    if (isLoading) return;
    isLoading = true;
    Overlay.of(context).insert(_overlayEntry);
  }

  void hideLoader() {
    if (!isLoading) return;
    _overlayEntry.remove();
    isLoading = false;
  }

  final OverlayEntry _overlayEntry = OverlayEntry(
    builder: (context) => Positioned.fill(
      child: FocusScope(
        autofocus: true,
        canRequestFocus: true,
        child: Focus(
          autofocus: true,
          canRequestFocus: true,
          child: Semantics(
            label: 'Caricamento operazione',
            excludeSemantics: true,
            child: ColoredBox(
              color: Dcolors.darkGreen,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
