import 'mosque_repository_base.dart';
import 'mosque_repository_io.dart'
    if (dart.library.html) 'mosque_repository_web.dart' as impl;

MosqueRepository get mosqueRepository => impl.createRepository();
