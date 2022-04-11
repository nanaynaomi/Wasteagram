import 'package:test/test.dart';
import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  test('Post created should have correct values', () {
    final date = DateTime.parse('2022-01-01').millisecondsSinceEpoch;
    const url = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    FoodWastePost post = FoodWastePost();
    post.date = date;
    post.url = url;
    post.quantity = quantity;
    post.latitude = latitude;
    post.longitude = longitude;

    expect(post.date, date);
    expect(post.url, url);
    expect(post.quantity, quantity);
    expect(post.latitude, latitude);
    expect(post.longitude, longitude);
  });

  test('Date converts correctly', () {
    final originalDate = DateTime.parse('2022-01-01');
    final date = originalDate.millisecondsSinceEpoch;

    FoodWastePost post = FoodWastePost();
    post.date = date;

    expect(DateTime.fromMillisecondsSinceEpoch(post.date!), originalDate);
  });
}


