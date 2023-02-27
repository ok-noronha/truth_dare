import "dart:math";

T getRandomElement<T>(List<T> list) {
  final random = Random();
  var i = random.nextInt(list.length);
  return list[i];
}

var list = [
  'images/choice4.jpg',
  'images/choice6.jpg',
  'images/choice1.png',
  'images/choice2.jpg',
  'images/choice7.jpg',
  'images/choice8.jpg',
  'images/choice9.jpg',
  'images/choice3.png',
  'images/choice10.png',
  'images/choice11.png',
  'images/choice12.png'
];

class ImageManager {
  static const backgroundImage = 'images/TorD_w.png';
  static const truthImage = 'images/TorD_w.png';
  static const dareImage = 'images/TorD_w.png';
  static const truthSide = 'images/angel1.jpg';
  static const dareSide = 'images/devil1.jpg';
  static const heaven = 'images/Heaven.jpg';
  static const hell = 'images/Hell.jpg';
  static getChoiceImg() => getRandomElement(list);
}
