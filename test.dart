void main() async {
  //Stream function
  Stream<int> countStream(int max) async* {
    for (int i = 0; i < max; i++) {
      yield i;
    }
  }

  Future<int> sumOfStream(Stream<int> stream) async {
    int sum = 0;
    await for (int i in stream) {
      sum += i;
    }

    return sum;
  }

  var sum = await sumOfStream(countStream(10));

  print(sum);
}
