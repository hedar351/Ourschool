import 'package:school/features/BulletinScreen/data/model/BulletinModel.dart';

abstract class RemotedataSource {
  Future<List<Bulletinmodel>> getBulletins();
}

class RemoteDataSourceImp implements RemotedataSource {
  @override
  Future<List<Bulletinmodel>> getBulletins() {
    // TODO: implement getBulletins
    throw UnimplementedError();
  }
}
