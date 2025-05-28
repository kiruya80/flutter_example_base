abstract class LocalCounterDataSource {
  Future<int> getCounter();
  Future<void> saveCounter(int value);
}
