// ignore_for_file: public_member_api_docs, sort_constructors_first
// Dependency Inversion Principle
// Entities Must Depend on abstraction not on Concretions.
// It States That The High level Modules Must not depend on the
// low module but they should depend on abstractions.

class Service {
  ConnectionInterface connection;
  Service(this.connection,
  );
  void attach() {
    connection.connect();
  }
}

abstract class ConnectionInterface {
  void connect();
}

class MyDBConnection implements ConnectionInterface {
  @override
  void connect() {
  }
}

class FirebaseDatabase implements ConnectionInterface {
  @override
  void connect() {
  }
}
