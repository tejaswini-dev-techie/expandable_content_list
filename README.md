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

A powerful and flexible Flutter package for displaying expandable sections of grouped content with smooth animations and customizable styling. Perfect for building modern, interactive UIs with collapsible content sections.

## 🌟 Features

- 📦 **Grouped Content Display**: Organize content into logical sections with expandable/collapsible functionality
- 🎯 **Smart Item Limiting**: Show a limited number of items initially with "See More/Less" toggle
- 🎨 **Highly Customizable**: 
  - Custom section headers
  - Custom item builders
  - Customizable text styles and colors
  - Flexible layout options
- ⚡ **Performance Optimized**: Built with Flutter's best practices for smooth scrolling and animations
- 📱 **Responsive Design**: Works seamlessly across different screen sizes
- 🎭 **Rich Styling Options**: 
  - Custom toggle button styles
  - Custom section header builders
  - Custom item builders
  - Custom separators
 
## 🌟 Visual Preview

![expandable_content_list+(1)](https://github.com/user-attachments/assets/10836449-41f3-440d-99b6-34320323387d)

## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  expandable_content_list: ^0.0.3
```

Or run:
```bash
flutter pub add expandable_content_list
```

## 🚀 Quick Start

```dart
import 'package:expandable_content_list/expandable_content_list.dart';

// Define your section model
class Section<T> {
  final String id;
  final String title;
  final List<T> items;
  
  const Section({
    required this.id,
    required this.title,
    required this.items,
  });
}

// Use the widget
ExpandableContentSection<ListItem, Section<ListItem>>(
  sections: [
    Section(
      id: '1',
      title: 'Featured Products',
      items: [
        ListItem(
          id: '1',
          title: 'Product 1',
          description: 'Description 1',
        ),
        // More items...
      ],
    ),
  ],
  limit: 2,
  seeMoreText: 'View All Products',
  seeLessText: 'Show Less',
  onItemTap: (item) {
    // Handle item tap
  },
);
```

## 🎨 Advanced Usage

### Custom Section Header
```dart
ExpandableContentSection(
  // ... other properties
  sectionHeaderBuilder: (section) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.withOpacity(0.1), Colors.blue.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.category),
          SizedBox(width: 12),
          Text(
            section.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  },
);
```

### Custom Item Builder
```dart
ExpandableContentSection(
  // ... other properties
  itemBuilder: (item) => Card(
    margin: const EdgeInsets.symmetric(vertical: 4),
    child: ListTile(
      title: Text(item.title),
      subtitle: Text(item.description),
      trailing: Icon(Icons.chevron_right),
    ),
  ),
);
```

## ⚙️ API Reference

### ExpandableContentSection Properties

| Property | Type | Description |
|----------|------|-------------|
| `sections` | `List<S>` | List of sections to display |
| `limit` | `int` | Number of items to show initially |
| `seeMoreText` | `String` | Text for the expand button |
| `seeLessText` | `String` | Text for the collapse button |
| `onItemTap` | `Function(T)` | Callback when an item is tapped |
| `toggleButtonStyle` | `ButtonStyle` | Style for the toggle button |
| `toggleButtonTextStyle` | `TextStyle` | Style for the toggle button text |
| `toggleButtonAlignment` | `Alignment` | Alignment of the toggle button |
| `itemBuilder` | `Widget Function(T)` | Custom builder for items |
| `sectionHeaderBuilder` | `Widget Function(S)` | Custom builder for section headers |

## 🎯 Use Cases

- Course content organization
- Product category listings
- FAQ sections
- News article categories
- Task lists with priorities
- Playlist organization
- Documentation sections

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


