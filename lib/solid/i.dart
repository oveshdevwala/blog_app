
// Interface Segregation Principle

abstract class Malmal {
  void see();
  void eat();
}

abstract class FlyMalmal {
  void fly();
}

class Dog implements Malmal {
  @override
  void eat() {
  }

  @override
  void see() {
  }
}

class Bird implements Malmal, FlyMalmal {
  @override
  void eat() {
  }

  @override
  void fly() {
  }

  @override
  void see() {
  }
}

