extension KeyForValueFinder<Key, Value> on Map<Key, Value> {
  Key keyForValue(Value valueToSearch) {
    Key result;
    forEach((key, value) {
      if (value == valueToSearch) {
        result = key;
        return;
      }
    });
    return result;
  }
}
