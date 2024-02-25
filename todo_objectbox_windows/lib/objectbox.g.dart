// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/todo_entity.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 2792323942115671649),
      name: 'TodoEntity',
      lastPropertyId: const IdUid(5, 2326727235874885599),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6528871271537413867),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3030243757508146199),
            name: 'task_title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1813553263977296703),
            name: 'task_description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5307592319937408340),
            name: 'task_done',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2326727235874885599),
            name: 'creation_date',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 2792323942115671649),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    TodoEntity: EntityDefinition<TodoEntity>(
        model: _entities[0],
        toOneRelations: (TodoEntity object) => [],
        toManyRelations: (TodoEntity object) => {},
        getId: (TodoEntity object) => object.id,
        setId: (TodoEntity object, int id) {
          object.id = id;
        },
        objectToFB: (TodoEntity object, fb.Builder fbb) {
          final task_titleOffset = object.task_title == null
              ? null
              : fbb.writeString(object.task_title!);
          final task_descriptionOffset = object.task_description == null
              ? null
              : fbb.writeString(object.task_description!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, task_titleOffset);
          fbb.addOffset(2, task_descriptionOffset);
          fbb.addBool(3, object.task_done);
          fbb.addInt64(4, object.creation_date?.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final creation_dateValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 12);
          final task_titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 6);
          final task_descriptionParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8);
          final task_doneParam =
              const fb.BoolReader().vTableGetNullable(buffer, rootOffset, 10);
          final creation_dateParam = creation_dateValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(creation_dateValue);
          final object = TodoEntity(
              task_title: task_titleParam,
              task_description: task_descriptionParam,
              task_done: task_doneParam,
              creation_date: creation_dateParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [TodoEntity] entity fields to define ObjectBox queries.
class TodoEntity_ {
  /// see [TodoEntity.id]
  static final id =
      QueryIntegerProperty<TodoEntity>(_entities[0].properties[0]);

  /// see [TodoEntity.task_title]
  static final task_title =
      QueryStringProperty<TodoEntity>(_entities[0].properties[1]);

  /// see [TodoEntity.task_description]
  static final task_description =
      QueryStringProperty<TodoEntity>(_entities[0].properties[2]);

  /// see [TodoEntity.task_done]
  static final task_done =
      QueryBooleanProperty<TodoEntity>(_entities[0].properties[3]);

  /// see [TodoEntity.creation_date]
  static final creation_date =
      QueryIntegerProperty<TodoEntity>(_entities[0].properties[4]);
}
