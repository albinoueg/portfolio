import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list/app/core/notifier/default_chage_notifier.dart';
import 'package:todo_list/app/core/ui/messages.dart';

class DefaultListenerNotifier {
  final DefaultChageNotifier changeNotifier;
  DefaultListenerNotifier({
    required this.changeNotifier,
  });

  void listener(
      {required BuildContext context,
      required SuccessVoidCallback successVoidCallback,
      EverVoidCallback? everVoidCallback,
      ErrorVoidCallback? errorVoidCallback}) {
    changeNotifier.addListener(() {
      if (everVoidCallback != null) {
        everVoidCallback(changeNotifier, this);
      }
      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changeNotifier.hasError) {
        if (errorVoidCallback != null) {
          errorVoidCallback(changeNotifier, this);
        }
        Messages.of(context).showError(changeNotifier.error ?? 'Erro interno');
      } else if (changeNotifier.isSuccess) {
        successVoidCallback(changeNotifier, this);
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SuccessVoidCallback = void Function(
    DefaultChageNotifier notifier, DefaultListenerNotifier listener);
typedef ErrorVoidCallback = void Function(
    DefaultChageNotifier notifier, DefaultListenerNotifier listener);
typedef EverVoidCallback = void Function(
    DefaultChageNotifier notifier, DefaultListenerNotifier listener);
