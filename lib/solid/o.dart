
// Open for Extention, Close for Modification Principle.
// Right Aproch
abstract class Shape {
  String area();
}

class Circle implements Shape {
  double radius;
  Circle({
    required this.radius,
  });
  @override
  String area() {
    return 'There is a circle $radius';
  }
}

class Square implements Shape {
  double length;
  Square({
    required this.length,
  });
  @override
  String area() {
    return 'This is a square $length';
  }
}

class AreaCalculator {
  Shape shape;
  AreaCalculator({
    required this.shape,
  });
  calculate() {
    shape.area();
  }
}
