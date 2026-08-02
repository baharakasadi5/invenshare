// lib/features/inventions/data/repositories/invention_repository_impl.dart

import '../../domain/entities/invention.dart';
import '../../domain/repositories/invention_repository.dart';

import '../sources/invention_local_source.dart';



class InventionRepositoryImpl 
    implements InventionRepository {



  final InventionLocalSource localSource;



  InventionRepositoryImpl(
    this.localSource,
  );



  @override
  Future<List<Invention>> getInventions() async {

    return await localSource.getInventions();

  }



  @override
  Future<void> addInvention(
    Invention invention,
  ) async {

    await localSource.addInvention(
      invention,
    );

  }



  @override
  Future<void> deleteInvention(
    String id,
  ) async {

    await localSource.deleteInvention(
      id,
    );

  }



  @override
  Future<void> updateInvention(
    Invention invention,
  ) async {

    await localSource.updateInvention(
      invention,
    );

  }


}