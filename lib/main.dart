import 'package:flutter/material.dart';

void main() {
  runApp(const RestaurantMenuApp());
}

class RestaurantMenuApp extends StatelessWidget {
  const RestaurantMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu du Restaurant',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MenuPage(title: 'Menu du Restaurant'),
    );
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required this.title});
  final String title;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['Entrées', 'Plats', 'Desserts'];

  // Définition des données des plats
  final List<List<Dish>> _menuItems = [
    // Entrées
    [
      Dish(
        name: 'Salade César',
        description: 'Salade romaine, croûtons, parmesan et sauce César',
        price: 9.50,
        imageUrl: 'assets/images/salade_cesar.jpg',
      ),
      Dish(
        name: 'Soupe à l\'oignon',
        description: 'Soupe traditionnelle avec croûtons et fromage gratiné',
        price: 8.00,
        imageUrl: 'assets/images/soupe_oignon.jpg',
      ),
      Dish(
        name: 'Foie Gras Maison',
        description: 'Accompagné de pain brioché et confiture de figues',
        price: 14.50,
        imageUrl: 'assets/images/foie_gras.jpg',
      ),
    ],
    // Plats
    [
      Dish(
        name: 'Steak Frites',
        description: 'Entrecôte grillée avec frites maison et sauce béarnaise',
        price: 22.00,
        imageUrl: 'assets/images/steak_frites.jpg',
      ),
      Dish(
        name: 'Risotto aux Champignons',
        description: 'Riz arborio, champignons sauvages et parmesan',
        price: 18.50,
        imageUrl: 'assets/images/risotto.jpg',
      ),
      Dish(
        name: 'Saumon Grillé',
        description: 'Pavé de saumon, légumes de saison et sauce hollandaise',
        price: 21.00,
        imageUrl: 'assets/images/saumon.jpg',
      ),
      Dish(
        name: 'Coq au Vin',
        description: 'Poulet mijoté au vin rouge avec lardons et champignons',
        price: 19.50,
        imageUrl: 'assets/images/coq_au_vin.jpg',
      ),
    ],
    // Desserts
    [
      Dish(
        name: 'Crème Brûlée',
        description: 'Crème vanillée avec sucre caramélisé',
        price: 7.50,
        imageUrl: 'assets/images/creme_brulee.jpg',
      ),
      Dish(
        name: 'Tarte au Citron Meringuée',
        description: 'Pâte sablée, crème de citron et meringue italienne',
        price: 8.00,
        imageUrl: 'assets/images/tarte_citron.jpg',
      ),
      Dish(
        name: 'Fondant au Chocolat',
        description: 'Gâteau au chocolat avec cœur coulant et glace vanille',
        price: 9.00,
        imageUrl: 'assets/images/fondant_chocolat.jpg',
      ),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Barre de catégories
          _buildCategorySelector(),

          // Liste des plats
          Expanded(
            child: _buildDishList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedCategoryIndex == index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surface,
                foregroundColor: _selectedCategoryIndex == index
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.primary,
                elevation: _selectedCategoryIndex == index ? 4 : 1,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
              ),
              child: Text(
                _categories[index],
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDishList() {
    // On vérifie si la catégorie sélectionnée est valide
    if (_selectedCategoryIndex < 0 || _selectedCategoryIndex >= _menuItems.length) {
      return const Center(child: Text('Catégorie non disponible'));
    }

    // Récupérer les plats de la catégorie sélectionnée
    final dishes = _menuItems[_selectedCategoryIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: dishes.map((dish) => DishCard(dish: dish)).toList(),
      ),
    );
  }
}

// Widget pour afficher une carte de plat
class DishCard extends StatelessWidget {
  final Dish dish;

  const DishCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image du plat
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
            child: Image.asset(
              dish.imageUrl,
              height: 180.0,
              width: double.infinity,
              fit: BoxFit.cover,
              // Fallback pour les images non disponibles
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180.0,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: const Icon(
                    Icons.restaurant,
                    size: 64.0,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),

          // Contenu de la carte
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ligne avec nom et prix
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Nom du plat
                    Expanded(
                      child: Text(
                        dish.name,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Prix du plat
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        '${dish.price.toStringAsFixed(2)} €',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8.0),

                // Description du plat
                Text(
                  dish.description,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey.shade700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Class pour un plat
class Dish {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Dish({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}