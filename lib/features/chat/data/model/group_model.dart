import '../../domain/entities/group.dart';

class GroupModel extends Group {
  GroupModel({
    required super.id,
    required super.name,
    required super.members,
    required super.createdBy,
  });

  factory GroupModel.fromMap(
      Map<String, dynamic> map,
      String documentId,
      ) {
    return GroupModel(
      id: documentId,
      name: map['name'] ?? '',
      members: List<String>.from(map['members'] ?? []),
      createdBy: map['createdBy'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': 'group',
      'members': members,
      'createdBy': createdBy,
    };
  }
}