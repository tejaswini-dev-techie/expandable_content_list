import 'package:flutter_test/flutter_test.dart';

import 'package:expandable_content_list/expandable_content_list.dart';

// Define ListItem class for testing
class ListItem {
  final String id;
  final String title;
  final String description;

  const ListItem({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  String toString() => title;
}

void main() {
  test('Section creates with correct data', () {
    const section = Section<ListItem>(
      id: '1',
      title: 'Test Section',
      items: [
        ListItem(
          id: '1',
          title: 'Test Item',
          description: 'Test Description',
        ),
      ],
    );

    expect(section.id, '1');
    expect(section.title, 'Test Section');
    expect(section.items.length, 1);
    expect(section.items.first.title, 'Test Item');
  });
}
