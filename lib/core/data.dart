import 'package:flutter/material.dart';

// Static demo content mirroring the Figma prototype. Prices are whole
// naira here; the real backend prices in kobo. Category tiles use
// Material icons instead of emoji so they render on every device.
abstract final class ChowPhotos {
  static const hero =
      'https://images.unsplash.com/photo-1665332195309-9d75071138f0?auto=format&fit=crop&w=1100&q=88';
  static const jollof =
      'https://images.unsplash.com/photo-1664992960082-0ea299a9c53e?auto=format&fit=crop&w=700&q=88';
  static const platter =
      'https://images.unsplash.com/photo-1665556899022-9761f95769e5?auto=format&fit=crop&w=700&q=88';
  static const rice =
      'https://images.unsplash.com/photo-1603496987674-79600a000f55?auto=format&fit=crop&w=700&q=88';
  static const egusi =
      'https://images.unsplash.com/photo-1763048443535-1243379234e2?auto=format&fit=crop&w=700&q=88';
  static const pastry =
      'https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?auto=format&fit=crop&w=700&q=88';
}

class Restaurant {
  const Restaurant({
    required this.name,
    required this.meta,
    required this.fee,
    required this.image,
  });
  final String name;
  final String meta;
  final String fee;
  final String image;
}

class Meal {
  const Meal({
    required this.name,
    required this.restaurant,
    required this.price,
    required this.image,
  });
  final String name;
  final String restaurant;
  final int price;
  final String image;
}

class Category {
  const Category({required this.name, required this.icon});
  final String name;
  final IconData icon;
}

abstract final class ChowData {
  static const restaurants = [
    Restaurant(
      name: 'Mama Jollof',
      meta: '4.8 · 25–35 min',
      fee: '₦650 delivery',
      image: ChowPhotos.hero,
    ),
    Restaurant(
      name: 'Yellow Bowl',
      meta: '4.6 · 20–30 min',
      fee: '₦500 delivery',
      image: ChowPhotos.rice,
    ),
    Restaurant(
      name: 'Sweet Crumbs',
      meta: '4.9 · 15–25 min',
      fee: '₦400 delivery',
      image: ChowPhotos.pastry,
    ),
  ];

  static const meals = [
    Meal(
      name: 'Smoky party jollof',
      restaurant: 'Mama Jollof',
      price: 2500,
      image: ChowPhotos.jollof,
    ),
    Meal(
      name: 'Grilled chicken bowl',
      restaurant: 'Yellow Bowl',
      price: 4500,
      image: ChowPhotos.rice,
    ),
    Meal(
      name: 'Egusi & soft swallow',
      restaurant: 'Native Pot',
      price: 3800,
      image: ChowPhotos.egusi,
    ),
  ];

  // Material icons stand in for the prototype's emoji tiles.
  static const categories = [
    Category(name: 'Local', icon: Icons.soup_kitchen),
    Category(name: 'Fast food', icon: Icons.fastfood),
    Category(name: 'Pastries', icon: Icons.bakery_dining),
    Category(name: 'Rice', icon: Icons.rice_bowl),
    Category(name: 'Grills', icon: Icons.kebab_dining),
    Category(name: 'Snacks', icon: Icons.cookie),
    Category(name: 'Drinks', icon: Icons.local_drink),
    Category(name: 'Desserts', icon: Icons.icecream),
    Category(name: 'Breakfast', icon: Icons.egg_alt),
    Category(name: 'Healthy', icon: Icons.spa),
  ];

  static const popularSearches = [
    'Jollof rice',
    'Chicken',
    'Shawarma',
    'Pastries',
  ];
}

String naira(int amount) {
  final grouped = amount.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]},',
  );
  return '₦$grouped';
}
