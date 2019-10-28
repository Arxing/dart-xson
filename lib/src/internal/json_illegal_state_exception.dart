class JsonIllegalStateException {
  String _message;

  JsonIllegalStateException([String message]) : _message = message;

  @override
  String toString() {
    return 'JsonIllegalStateException(), message=$_message';
  }
}
