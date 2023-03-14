import 'dart:ffi';

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
  bool isTrue();
  bool reversed = false;
  Notification parent = Notification();
}

class ConditionNear extends ConditionNull {
  @override
  bool isTrue() {
    return false;
  }
}

class ConditionMoment extends ConditionNull {
  @override
  bool isTrue() {
    return false;
  }
}

class ConditionPeriod extends ConditionNull {
  @override
  bool isTrue() {
    return false;
  }
}

class ConditionByCondition extends ConditionNull {
  @override
  bool isTrue() {
    return false;
  }
}
