import 'package:hive/hive.dart';
import '../../domain/entities/invention.dart';

class InventionLocalDataSource {

  final Box<Invention> box;

  InventionLocalDataSource(this.box);


  List<Invention> getAll(){

    return box.values.toList();

  }


  Future<void> add(Invention invention) async {

    await box.put(
      invention.id,
      invention,
    );

  }


  Future<void> delete(String id) async {

    await box.delete(id);

  }

}