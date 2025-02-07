// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_dont_list/comments.dart';

import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/to_do_items.dart';

void main() {
  test('Item abbreviation should be first letter', () {
    const item = Item(name: "add more todos");
    expect(item.abbrev(), "a");
  });

  // Yes, you really need the MaterialApp and Scaffold
  testWidgets('ToDoListItem has a text', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ToDoListItem(
                item: const Item(name: "test"),
                completed: true,
                onListChanged: (Item item, bool completed) {},
                onDeleteItem: (Item item) {}))));
    final textFinder = find.text('test');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Default ToDoList has one item', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    final listItemFinder = find.byType(ToDoListItem);

    expect(listItemFinder, findsOneWidget);
  });

  test('ImagePicker Checker', () {
    // check both image sources
    ImagePicker imgpick = ImagePicker();

    var source = ImageSource.camera;

    imgpick.pickImage(
        source: source,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);

    var source2 = ImageSource.gallery;

    imgpick.pickImage(
        source: source2,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
  });

  test('ImageGallery Checker', () {
    var type = ImageSourceType.camera;

    ImageFromGallery imageFromGallery = ImageFromGallery(type);
    expect(type, ImageSourceType.camera);

    var type2 = ImageSourceType.gallery;

    ImageFromGallery imageFromGallery2 = ImageFromGallery(type2);
    expect(type2, ImageSourceType.gallery);
  });

  testWidgets('Nav opens Page', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    // find the page two navigator button and push it
    expect(find.byType(ListTile), findsNWidgets(1));
    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();
    await tester.pump(); // Pump after every action to rebuild the widgets
  });

  testWidgets('Image Page has 2 buttons', (tester) async {
    await tester.pumpWidget(MaterialApp(home: PageTwo()));
    expect(find.byType(MaterialButton), findsNWidgets(2));
  });

  testWidgets('Comments List has 1 comment', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: CommentList(
                comment: const Comment(content: "test"),
                completed: true,
                onComListChanged: (Comment comment, bool completed) {},
                onDeleteComment: (Comment comment) {}))));
    final textFinder = find.text('test');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Default Comment list has one item', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PageThree()));

    final listItemFinder = find.byType(CommentList);

    expect(listItemFinder, findsOneWidget);
  });
}
