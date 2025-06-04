// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:expandable_content_list/expandable_content_list.dart';

// Define a model for list items
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

// Example 1: Simple List without Sections
class SimpleListExample extends StatelessWidget {
  const SimpleListExample({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      const ListItem(
        id: '1',
        title: 'First Item',
        description: 'Description for first item',
      ),
      const ListItem(
        id: '2',
        title: 'Second Item',
        description: 'Description for second item',
      ),
      const ListItem(
        id: '3',
        title: 'Third Item',
        description: 'Description for third item',
      ),
      const ListItem(
        id: '4',
        title: 'Fourth Item',
        description: 'Description for fourth item',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ExpandableContentSection.list<ListItem>(
        items: items,
        limit: 2,
        seeMoreText: 'Load More Items',
        seeLessText: 'Collapse List',
        onItemTap: (item) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tapped: ${item.title}')),
          );
        },
        toggleButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.blue.withOpacity(0.1),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: Colors.blue.withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
        ),
        toggleButtonTextStyle: const TextStyle(
          color: Colors.blue,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        toggleButtonAlignment: Alignment.centerRight,
        toggleButtonPadding: const EdgeInsets.only(right: 16, top: 8),
        itemBuilder: (item) => Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(item.description),
          ),
        ),
      ),
    );
  }
}

// Example 2: Product Categories with Sections
class ProductCategory {
  final String name;
  final String icon;
  final List<ListItem> products;
  final bool isFeatured;

  const ProductCategory({
    required this.name,
    required this.icon,
    required this.products,
    this.isFeatured = false,
  });

  ProductCategory copyWithItems(List<ListItem> newItems) {
    return ProductCategory(
      name: name,
      icon: icon,
      products: newItems,
      isFeatured: isFeatured,
    );
  }
}

class ProductCategoriesExample extends StatelessWidget {
  const ProductCategoriesExample({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      const ProductCategory(
        name: 'Premium Electronics',
        icon: '🎮',
        products: [
          ListItem(
            id: 'e1',
            title: 'Gaming Laptop Pro',
            description:
                'High-performance gaming laptop with RTX 4090, 32GB RAM, and 2TB SSD',
          ),
          ListItem(
            id: 'e2',
            title: 'Wireless Earbuds Elite',
            description:
                'Premium noise-cancelling wireless earbuds with 30-hour battery life',
          ),
          ListItem(
            id: 'e3',
            title: 'Smart Watch Series 5',
            description:
                'Advanced health monitoring smartwatch with ECG and blood oxygen tracking',
          ),
        ],
        isFeatured: true,
      ),
      const ProductCategory(
        name: 'Home & Kitchen',
        icon: '🏠',
        products: [
          ListItem(
            id: 'h1',
            title: 'Smart Coffee Maker',
            description:
                'WiFi-enabled coffee maker with app control and scheduling',
          ),
          ListItem(
            id: 'h2',
            title: 'Robot Vacuum Pro',
            description:
                'AI-powered robot vacuum with mapping and self-emptying base',
          ),
          ListItem(
            id: 'h3',
            title: 'Smart Air Purifier',
            description:
                'HEPA air purifier with real-time air quality monitoring',
          ),
        ],
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Featured Categories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Explore our premium product categories',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          ExpandableContentSection<ListItem, ProductCategory>(
            sections: categories,
            limit: 2,
            seeMoreText: 'View All Products',
            seeLessText: 'Show Less',
            onItemTap: (item) {},
            getItems: (category) => category.products,
            getTitle: (category) => category.name,
            getDescription: (category) =>
                category.isFeatured ? 'Featured Category' : null,
            createCopyWithItems: (category, items) =>
                category.copyWithItems(items),
            toggleButtonStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.deepPurple.withOpacity(0.1),
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(
                    color: Colors.deepPurple.withOpacity(0.5),
                    width: 1,
                  ),
                ),
              ),
            ),
            toggleButtonTextStyle: const TextStyle(
              color: Colors.deepPurple,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            toggleButtonAlignment: Alignment.center,
            toggleButtonPadding: const EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (item) => Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    item.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ),
            sectionHeaderBuilder: (category) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      category.isFeatured
                          ? Colors.deepPurple.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      category.isFeatured
                          ? Colors.deepPurple.withOpacity(0.05)
                          : Colors.grey.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: category.isFeatured
                            ? Colors.deepPurple.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        category.icon,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: category.isFeatured
                                  ? Colors.deepPurple
                                  : Colors.black87,
                            ),
                          ),
                          if (category.isFeatured) ...[
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Featured Category',
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Example 3: News Articles with Modern Design
class NewsArticle {
  final String id;
  final String title;
  final String description;
  final String category;
  final DateTime date;

  const NewsArticle({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
  });
}

class NewsArticlesExample extends StatelessWidget {
  const NewsArticlesExample({super.key});

  @override
  Widget build(BuildContext context) {
    final articles = [
      NewsArticle(
        id: 'n1',
        title: 'Tech Industry Trends 2024',
        description: 'Exploring the latest trends in technology and innovation',
        category: 'Technology',
        date: DateTime(2024, 3, 15),
      ),
      NewsArticle(
        id: 'n2',
        title: 'Sustainable Living',
        description: 'How to make your lifestyle more eco-friendly',
        category: 'Lifestyle',
        date: DateTime(2024, 3, 14),
      ),
      NewsArticle(
        id: 'n3',
        title: 'Digital Transformation',
        description: 'The impact of digital transformation on businesses',
        category: 'Business',
        date: DateTime(2024, 3, 13),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Latest News',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Stay updated with the latest news and articles',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          ExpandableContentSection.list<NewsArticle>(
            items: articles,
            limit: 2,
            seeMoreText: 'Read More Articles',
            seeLessText: 'Show Less Articles',
            onItemTap: (article) {},
            toggleButtonStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.teal.withOpacity(0.1),
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(
                    color: Colors.teal.withOpacity(0.5),
                    width: 1,
                  ),
                ),
              ),
            ),
            toggleButtonTextStyle: const TextStyle(
              color: Colors.teal,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            toggleButtonAlignment: Alignment.center,
            toggleButtonPadding: const EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (article) => Card(
              elevation: 0,
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        article.description,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            article.category,
                            style: const TextStyle(
                              color: Colors.teal,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          article.date.toString(),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Example 4: Task List with Priority Sections
class Task {
  final String id;
  final String title;
  final String description;
  final int priority;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
  });
}

class TaskSection {
  final String name;
  final List<Task> tasks;
  final Color color;

  const TaskSection({
    required this.name,
    required this.tasks,
    required this.color,
  });

  TaskSection copyWithItems(List<Task> newItems) {
    return TaskSection(
      name: name,
      tasks: newItems,
      color: color,
    );
  }
}

class TaskListExample extends StatelessWidget {
  const TaskListExample({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      const TaskSection(
        name: 'High Priority',
        color: Colors.red,
        tasks: [
          Task(
            id: 'h1',
            title: 'Complete Project Proposal',
            description: 'Finish the project proposal document',
            priority: 1,
          ),
          Task(
            id: 'h2',
            title: 'Client Meeting',
            description: 'Prepare for the client presentation',
            priority: 1,
          ),
        ],
      ),
      const TaskSection(
        name: 'Medium Priority',
        color: Colors.orange,
        tasks: [
          Task(
            id: 'm1',
            title: 'Code Review',
            description: 'Review team members\' code',
            priority: 2,
          ),
          Task(
            id: 'm2',
            title: 'Update Documentation',
            description: 'Update project documentation',
            priority: 2,
          ),
        ],
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ExpandableContentSection<Task, TaskSection>(
        sections: sections,
        limit: 2,
        seeMoreText: 'View All Tasks',
        seeLessText: 'Collapse Tasks',
        onItemTap: (task) {},
        getItems: (section) => section.tasks,
        getTitle: (section) => section.name,
        getDescription: (section) => '${section.tasks.length} tasks',
        createCopyWithItems: (section, items) => section.copyWithItems(items),
        toggleButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.red.withOpacity(0.1),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Colors.red.withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
        ),
        toggleButtonTextStyle: const TextStyle(
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        toggleButtonAlignment: Alignment.centerRight,
        toggleButtonPadding: const EdgeInsets.only(right: 16, top: 8),
        sectionHeaderBuilder: (section) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: section.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.flag,
                  color: section.color,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: section.color,
                        ),
                      ),
                      Text(
                        '${section.tasks.length} tasks',
                        style: TextStyle(
                          color: section.color.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        itemBuilder: (task) => Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: sections
                  .firstWhere((s) => s.tasks.contains(task))
                  .color
                  .withOpacity(0.1),
              child: Text(
                task.priority.toString(),
                style: TextStyle(
                  color:
                      sections.firstWhere((s) => s.tasks.contains(task)).color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              task.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(task.description),
          ),
        ),
      ),
    );
  }
}

// Example 5: FAQ Section with Expandable Answers
class FAQ {
  final String id;
  final String question;
  final String answer;

  const FAQ({
    required this.id,
    required this.question,
    required this.answer,
  });
}

class FAQSection {
  final String title;
  final List<FAQ> faqs;

  const FAQSection({
    required this.title,
    required this.faqs,
  });

  FAQSection copyWithItems(List<FAQ> newItems) {
    return FAQSection(
      title: title,
      faqs: newItems,
    );
  }
}

class FAQExample extends StatelessWidget {
  const FAQExample({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      const FAQSection(
        title: 'General Questions',
        faqs: [
          FAQ(
            id: 'g1',
            question: 'What is this app about?',
            answer:
                'This is a demo app showcasing different ways to use the ExpandableContentSection widget.',
          ),
          FAQ(
            id: 'g2',
            question: 'How do I get started?',
            answer:
                'You can start by exploring the different examples in this app.',
          ),
        ],
      ),
      const FAQSection(
        title: 'Technical Questions',
        faqs: [
          FAQ(
            id: 't1',
            question: 'How do I customize the widget?',
            answer:
                'You can customize the widget using various properties like toggleButtonStyle, itemBuilder, etc.',
          ),
          FAQ(
            id: 't2',
            question: 'Can I use it without sections?',
            answer:
                'Yes, you can use the widget without sections using the list constructor.',
          ),
        ],
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Find answers to common questions',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          ExpandableContentSection<FAQ, FAQSection>(
            sections: sections,
            limit: 1,
            seeMoreText: 'View All Questions',
            seeLessText: 'Show Less Questions',
            onItemTap: (faq) {},
            getItems: (section) => section.faqs,
            getTitle: (section) => section.title,
            getDescription: (section) => '${section.faqs.length} questions',
            createCopyWithItems: (section, items) =>
                section.copyWithItems(items),
            toggleButtonStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.purple.withOpacity(0.1),
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.purple.withOpacity(0.5),
                    width: 1,
                  ),
                ),
              ),
            ),
            toggleButtonTextStyle: const TextStyle(
              color: Colors.purple,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            toggleButtonAlignment: Alignment.center,
            toggleButtonPadding: const EdgeInsets.symmetric(vertical: 12),
            sectionHeaderBuilder: (section) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.help_outline,
                      color: Colors.purple,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            section.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          Text(
                            '${section.faqs.length} questions',
                            style: TextStyle(
                              color: Colors.purple.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemBuilder: (faq) => Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ExpansionTile(
                title: Text(
                  faq.question,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      faq.answer,
                      style: TextStyle(
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Expandable Content List Examples'),
          backgroundColor: Colors.deepPurple.shade100,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Example 1: Simple List without Sections
              const SimpleListExample(),
              const Divider(height: 16),

              // Example 2: Product Categories with Sections
              const ProductCategoriesExample(),
              const Divider(height: 16),

              // Example 3: News Articles with Modern Design
              const NewsArticlesExample(),
              const Divider(height: 16),

              // Example 4: Task List with Priority Sections
              const TaskListExample(),
              const Divider(height: 16),

              // Example 5: FAQ Section with Expandable Answers
              const FAQExample(),
            ],
          ),
        ),
      ),
    );
  }
}
