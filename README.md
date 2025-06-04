<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Expandable Content List

A Flutter package for displaying expandable content modules with a "See More/Less" toggle.

## Features

- Display a list of expandable content modules
- Show a limited number of items initially
- "See More/Less" toggle functionality
- Auto-scroll to expanded list
- Customizable styles and layouts
- Support for custom item builders
- Optional separator widget

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  expandable_content_list: ^0.1.0
```

## Usage

```dart
import 'package:expandable_content_list/expandable_content_list.dart';

// Create your content modules
final modules = [
  ContentModule(
    moduleId: '1',
    moduleTitle: 'Module 1',
    items: [
      ContentItem(
        id: '1',
        title: 'Item 1',
        description: 'Description for item 1',
      ),
      ContentItem(
        id: '2',
        title: 'Item 2',
        description: 'Description for item 2',
      ),
    ],
  ),
  // Add more modules...
];

// Use the widget
ExpandableContentSection(
  modules: modules,
  limit: 5,
  seeMoreText: 'See More',
  seeLessText: 'Show Less',
  onItemTap: (item) {
    // Handle item tap
    print('Tapped item: ${item.title}');
  },
  moduleTitleTextStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
  itemTextStyle: TextStyle(
    fontSize: 16,
  ),
  separator: ContentSeparator(
    color: Colors.grey,
    thickness: 1.0,
  ),
);
```

## Customization

The package provides several customization options:

- `moduleTitleTextStyle`: Custom text style for module titles
- `itemTextStyle`: Custom text style for item titles
- `toggleButtonStyle`: Custom style for the toggle button
- `itemBuilder`: Custom builder for content items
- `separator`: Custom separator widget between items

## Example

```dart
// Custom item builder example
ExpandableContentSection(
  modules: modules,
  limit: 5,
  seeMoreText: 'See More',
  seeLessText: 'Show Less',
  onItemTap: (item) => print('Tapped: ${item.title}'),
  itemBuilder: (item) => Card(
    child: ListTile(
      leading: Icon(Icons.article),
      title: Text(item.title),
      subtitle: Text(item.description ?? ''),
      trailing: Icon(Icons.chevron_right),
    ),
  ),
);
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
