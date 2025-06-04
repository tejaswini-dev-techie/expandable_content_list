import 'package:flutter/material.dart';

/// A widget that displays a list of expandable content modules with a "See More/Less" toggle
class ExpandableContentSection<T, S> extends StatefulWidget {
  /// List of sections to display
  final List<S> sections;

  /// Number of items to show initially
  final int limit;

  /// Text to show on the "See More" button
  final String seeMoreText;

  /// Text to show on the "See Less" button
  final String seeLessText;

  /// Callback when an item is tapped
  final Function(T) onItemTap;

  /// Optional scroll key for auto-scrolling
  final GlobalKey? scrollKey;

  /// Optional custom text style for section titles
  final TextStyle? moduleTitleTextStyle;

  /// Optional custom text style for item titles
  final TextStyle? itemTextStyle;

  /// Optional custom style for the toggle button
  final ButtonStyle? toggleButtonStyle;

  /// Optional custom builder for content items
  final Widget Function(T)? itemBuilder;

  /// Optional separator widget between items
  final Widget? separator;

  /// Optional alignment for the toggle button
  final Alignment toggleButtonAlignment;

  /// Optional text style for the toggle button
  final TextStyle? toggleButtonTextStyle;

  /// Optional padding for the toggle button
  final EdgeInsetsGeometry? toggleButtonPadding;

  /// Optional padding for section titles
  final EdgeInsetsGeometry? sectionTitlePadding;

  /// Optional custom builder for section headers
  final Widget Function(S)? sectionHeaderBuilder;

  /// Function to get items from a section
  final List<T> Function(S) getItems;

  /// Function to get title from a section
  final String? Function(S) getTitle;

  /// Function to get description from a section
  final String? Function(S) getDescription;

  /// Function to create a copy of a section with new items
  final S Function(S, List<T>) createCopyWithItems;

  const ExpandableContentSection({
    super.key,
    required this.sections,
    required this.limit,
    required this.seeMoreText,
    required this.seeLessText,
    required this.onItemTap,
    required this.getItems,
    required this.getTitle,
    required this.getDescription,
    required this.createCopyWithItems,
    this.scrollKey,
    this.moduleTitleTextStyle,
    this.itemTextStyle,
    this.toggleButtonStyle,
    this.itemBuilder,
    this.separator,
    this.toggleButtonAlignment = Alignment.centerRight,
    this.toggleButtonTextStyle,
    this.toggleButtonPadding,
    this.sectionTitlePadding,
    this.sectionHeaderBuilder,
  });

  /// A convenience constructor for when you only want to show a list of items without sections
  static ExpandableContentSection<T, Section<T>> list<T>({
    Key? key,
    required List<T> items,
    required int limit,
    required String seeMoreText,
    required String seeLessText,
    required Function(T) onItemTap,
    GlobalKey? scrollKey,
    TextStyle? itemTextStyle,
    ButtonStyle? toggleButtonStyle,
    Widget Function(T)? itemBuilder,
    Widget? separator,
    Alignment toggleButtonAlignment = Alignment.centerRight,
    TextStyle? toggleButtonTextStyle,
    EdgeInsetsGeometry? toggleButtonPadding,
  }) {
    final section = Section<T>(items: items);
    return ExpandableContentSection<T, Section<T>>(
      key: key,
      sections: [section],
      limit: limit,
      seeMoreText: seeMoreText,
      seeLessText: seeLessText,
      onItemTap: onItemTap,
      getItems: (section) => section.items,
      getTitle: (section) => section.title,
      getDescription: (section) => section.description,
      createCopyWithItems: (section, items) => section.copyWith(items: items),
      scrollKey: scrollKey,
      itemTextStyle: itemTextStyle,
      toggleButtonStyle: toggleButtonStyle,
      itemBuilder: itemBuilder,
      separator: separator,
      toggleButtonAlignment: toggleButtonAlignment,
      toggleButtonTextStyle: toggleButtonTextStyle,
      toggleButtonPadding: toggleButtonPadding,
    );
  }

  @override
  State<ExpandableContentSection<T, S>> createState() =>
      _ExpandableContentSectionState<T, S>();
}

class _ExpandableContentSectionState<T, S>
    extends State<ExpandableContentSection<T, S>> {
  late ValueNotifier<bool> _expanded;
  late List<S> _limitedSections;
  late bool _showSeeMoreCTA;
  int _totalItemsCount = 0;

  @override
  void initState() {
    super.initState();
    _expanded = ValueNotifier(false);
    _calculateTotalItems();
    _initializeLimitedSections();
  }

  void _calculateTotalItems() {
    if (widget.sections.isEmpty) {
      _totalItemsCount = 0;
      _showSeeMoreCTA = false;
      return;
    }

    _totalItemsCount = widget.sections.fold(
      0,
      (sum, section) => sum + widget.getItems(section).length,
    );
    _showSeeMoreCTA = _totalItemsCount > widget.limit;
  }

  void _initializeLimitedSections() {
    if (widget.sections.isEmpty) {
      _limitedSections = [];
      return;
    }

    if (!_showSeeMoreCTA) {
      _limitedSections = List.from(widget.sections);
      return;
    }

    _limitedSections = [];
    int count = 0;

    for (var section in widget.sections) {
      if (count >= widget.limit) break;

      List<T> limitedItems = [];
      for (var item in widget.getItems(section)) {
        if (count >= widget.limit) break;
        limitedItems.add(item);
        count++;
      }

      _limitedSections.add(widget.createCopyWithItems(section, limitedItems));
    }
  }

  void _toggleExpanded() {
    _expanded.value = !_expanded.value;

    if (widget.scrollKey?.currentContext != null && !_expanded.value) {
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          Scrollable.ensureVisible(
            widget.scrollKey!.currentContext!,
            alignment: 0.2,
            duration: const Duration(milliseconds: 500),
          );
        },
      );
    }
  }

  Widget _buildModuleTitle(S section) {
    if (widget.sectionHeaderBuilder != null) {
      return widget.sectionHeaderBuilder!(section);
    }

    final title = widget.getTitle(section);
    if (title == null || title.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: widget.sectionTitlePadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: widget.moduleTitleTextStyle ??
                const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (widget.getDescription(section) != null &&
              widget.getDescription(section)!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                widget.getDescription(section)!,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContentItem(T item) {
    if (widget.itemBuilder != null) {
      return widget.itemBuilder!(item);
    }

    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      visualDensity: VisualDensity.compact,
      title: Text(
        item.toString(),
        style: widget.itemTextStyle,
      ),
      onTap: () => widget.onItemTap(item),
    );
  }

  Widget _buildToggleButton() {
    return Align(
      alignment: widget.toggleButtonAlignment,
      child: Padding(
        key: widget.scrollKey,
        padding: widget.toggleButtonPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: TextButton(
          onPressed: _toggleExpanded,
          style: widget.toggleButtonStyle,
          child: Text(
            _expanded.value ? widget.seeLessText : widget.seeMoreText,
            style: widget.toggleButtonTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _expanded,
      builder: (context, isExpanded, child) {
        final sectionsToShow = isExpanded ? widget.sections : _limitedSections;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...sectionsToShow.expand((section) => [
                  _buildModuleTitle(section),
                  ...widget
                      .getItems(section)
                      .map((item) => _buildContentItem(item)),
                  if (widget.separator != null) widget.separator!,
                ]),
            if (_showSeeMoreCTA) _buildToggleButton(),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _expanded.dispose();
    super.dispose();
  }
}

/// A default implementation of a section that can be used if no custom section is needed
class Section<T> {
  final String? id;
  final String? title;
  final String? description;
  final String? subtitle;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final List<T> items;
  final Map<String, dynamic>? metadata;

  const Section({
    this.id,
    this.title,
    this.description,
    this.subtitle,
    this.icon,
    this.backgroundColor,
    this.textColor,
    required this.items,
    this.metadata,
  });

  /// Creates a copy of this section with the given fields replaced with the new values
  Section<T> copyWith({
    String? id,
    String? title,
    String? description,
    String? subtitle,
    IconData? icon,
    Color? backgroundColor,
    Color? textColor,
    List<T>? items,
    Map<String, dynamic>? metadata,
  }) {
    return Section<T>(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      subtitle: subtitle ?? this.subtitle,
      icon: icon ?? this.icon,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      items: items ?? this.items,
      metadata: metadata ?? this.metadata,
    );
  }
}
