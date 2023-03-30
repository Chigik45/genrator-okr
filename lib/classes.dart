import 'dart:ffi';

import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

class Folder {
  List<Notification> notifications = List<Notification>.empty();

  void addNotification(Notification added) {
    notifications.add(added);
  }

  void removeNotification(String name) {
    for (int i = 0; i < notifications.length; ++i) {
      if (notifications[i].name == name) {
        notifications.removeAt(i);
        return;
      }
    }
  }
}

class Notification {
  List<ConditionNull> conditions = List<ConditionNull>.empty();
  String name = "__null__";
  bool check() {
    for (int i = 0; i < conditions.length; ++i) {
      if (!conditions[i].isTrue()) return false;
    }
    return true;
  }

  void addCondition(ConditionNull added) {
    added.parent = this;
    conditions.add(added);
  }

  void removeCondition(int index) {
    conditions.removeAt(index);
  }

  Notification(String name) {
    this.name = name;
  }
}

abstract class ConditionNull {
  int id = -1;
  bool triggered = false;

  ConditionNull(int id) {
    this.id = id;
  }
  bool isTrue();
  bool reversed = false;
  Notification parent = Notification("_");
}

class ConditionNear extends ConditionNull {
  // Position position = null;
  ConditionNear(int id /*, Position position*/) : super(id) {
    /*
    this.position = position;
    */
  }
  @override
  bool isTrue() {
    bool near = false;
    return !triggered && near;
  }
}

class ConditionMoment extends ConditionNull {
  DateTime moment = DateTime.now();
  ConditionMoment(int id, DateTime moment) : super(id) {
    this.moment = moment;
  }

  @override
  bool isTrue() {
    if (DateTime.now().millisecondsSinceEpoch >=
            moment.millisecondsSinceEpoch &&
        !triggered) {
      triggered = true;
      return true;
    }
    return false;
  }
}

class ConditionByCondition extends ConditionNull {
  ConditionNull following =
      ConditionByCondition(-1, ConditionMoment(-1, DateTime.now()));
  ConditionByCondition(int id, ConditionNull following) : super(id) {
    this.following = following;
  }

  @override
  bool isTrue() {
    return following.isTrue();
  }
}
