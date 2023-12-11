abstract class NetworkInfo{
  Future<bool> isConnected();
}

class NetworkInfoImpl extends NetworkInfo{
  @override
  Future<bool> isConnected() async{
    return true;
  }

}