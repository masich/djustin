extension KeyForValueFinder<Key, Value> on Map<Key, Value> {
  Key keyForValue(Value value) {
    Key result;
    forEach((key, value) {
      if (value == this) {
        result = key;
      }
    });
    return result;
  }
}
