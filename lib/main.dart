import 'package:animate_do/animate_do.dart';
import 'package:flushoes/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ShoeItemData> shoeItems = [
    ShoeItemData(
      name: 'Nike',
      brand: 'Nike',
      price: 99.99,
      image: 'assets/images/one.jpg',
    ),
    ShoeItemData(
      name: 'Nike',
      brand: 'Adidas',
      price: 89.99,
      image: 'assets/images/three.jpg',
    ),
    ShoeItemData(
      name: 'Adidas',
      brand: 'Puma',
      price: 79.99,
      image: 'assets/images/two.jpg',
    ),
    ShoeItemData(
      name: 'Running Shoe 04',
      brand: 'Nike',
      price: 109.99,
      image: 'assets/images/three.jpg',
    ),
    ShoeItemData(
      name: 'Adidas',
      brand: 'Adidas',
      price: 119.99,
      image: 'assets/images/two.jpg',
    ),
    ShoeItemData(
      name: 'Puma',
      brand: 'Puma',
      price: 99.99,
      image: 'assets/images/one.jpg',
    ),
    ShoeItemData(
      name: 'Adidas',
      brand: 'Nike',
      price: 109.99,
      image: 'assets/images/two.jpg',
    ),
    ShoeItemData(
      name: 'Running Shoe 08',
      brand: 'Adidas',
      price: 89.99,
      image: 'assets/images/three.jpg',
    ),
    ShoeItemData(
      name: 'Puma',
      brand: 'Puma',
      price: 79.99,
      image: 'assets/images/two.jpg',
    ),
    ShoeItemData(
      name: 'Puma',
      brand: 'Nike',
      price: 99.99,
      image: 'assets/images/one.jpg',
    ),
  ];

  final List<String> filters = [
    'All',
    'Nike',
    'Adidas',
    'Puma',
  ];

  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1A1A1A),
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Howdy,",
          style: GoogleFonts.dmSans(
            color: Colors.grey[200],
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoritesPage(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.favorite_sharp,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    //Cart Page Here
                  },
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return _buildDesktopLayout();
          } else if (constraints.maxWidth > 400) {
            return _buildTabletLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          elevation: 0,
          backgroundColor: const Color(0xff1a1a1a),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: _buildFilterButtons(),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildShoeItems(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          elevation: 0,
          backgroundColor: const Color(0xff1a1a1a),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 16),
                _buildFilterButtons(),
              ],
            ),
          ),
        ),
        SliverGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 0.7,
          children: shoeItems
              .where(
                (shoe) =>
                    selectedFilter == 'All' || shoe.brand == selectedFilter,
              )
              .map(
                (shoe) => StaggeredAnimationItem(
                  index: shoeItems.indexOf(shoe),
                  shoeItemData: shoe,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          elevation: 0,
          backgroundColor: const Color(0xff1a1a1a),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 16),
                _buildFilterButtons(),
              ],
            ),
          ),
        ),
        SliverGrid.count(
          crossAxisCount: 3,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 0.7,
          children: shoeItems
              .where(
                (shoe) =>
                    selectedFilter == 'All' || shoe.brand == selectedFilter,
              )
              .map(
                (shoe) => StaggeredAnimationItem(
                  index: shoeItems.indexOf(shoe),
                  shoeItemData: shoe,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 45,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: filters
              .map(
                (filter) => AspectRatio(
                  aspectRatio: 2.1 / 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Container(
                      margin: filter == selectedFilter
                          ? const EdgeInsets.all(2)
                          : const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: filter == selectedFilter
                            ? Colors.grey[200]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          filter,
                          style: GoogleFonts.dmSans(
                            fontSize: 20,
                            color: filter == selectedFilter
                                ? Colors.black
                                : Colors.grey[200],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildShoeItems() {
    return Column(
      children: shoeItems
          .where(
            (shoe) => selectedFilter == 'All' || shoe.brand == selectedFilter,
          )
          .map(
            (shoe) => StaggeredAnimationItem(
              index: shoeItems.indexOf(shoe),
              shoeItemData: shoe,
            ),
          )
          .toList(),
    );
  }
}

class StaggeredAnimationItem extends StatelessWidget {
  final int index;
  final ShoeItemData shoeItemData;

  const StaggeredAnimationItem({
    Key? key,
    required this.index,
    required this.shoeItemData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int delayMultiplier = index;
    final Duration delay = Duration(milliseconds: 100 * delayMultiplier);

    return SlideInUp(
      duration: Duration(seconds: 1),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Shoes(
                shoeItemData: shoeItemData,
              ),
            ),
          );
        },
        child: Container(
          height: 250,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(shoeItemData.image),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          shoeItemData.name,
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          shoeItemData.brand,
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: Text(
                        "\$${shoeItemData.price.toStringAsFixed(2)}",
                        style: GoogleFonts.dmSans(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Shoes extends StatelessWidget {
  final ShoeItemData shoeItemData;

  const Shoes({
    Key? key,
    required this.shoeItemData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool isFavorite = favoritesProvider.favorites.contains(shoeItemData);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(shoeItemData.image),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 10,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        favoritesProvider.toggleFavorite(shoeItemData);
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFavorite ? Colors.red : Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            size: 20,
                            color: isFavorite ? Colors.white : Colors.red,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cartProvider.addToCart(shoeItemData);
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.shopping_cart,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(.9),
                        Colors.black.withOpacity(.0),
                      ],
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          shoeItemData.name,
                          style: GoogleFonts.dmSans(
                            color: Colors.grey[200],
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Size",
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "40",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "42",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "45",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Description",
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "These running shoes are perfect for all your athletic needs. They are comfortable and provide great support. You can run for miles without any discomfort.",
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "\$${shoeItemData.price.toStringAsFixed(2)}",
                              style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 150,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Add to Cart",
                                  style: GoogleFonts.dmSans(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
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
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final List<ShoeItemData> favorites = favoritesProvider.favorites;

    return Scaffold(
      backgroundColor: Color(0xff1a1a1a),
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Howdy,",
          style: GoogleFonts.dmSans(
            color: Colors.grey[200],
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    favoritesProvider.clearFavorites();
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckoutPage(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final shoe = favorites[index];
            return StaggeredAnimationItem(
              index: index,
              shoeItemData: shoe,
            );
          },
        ),
      ),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final List<ShoeItemData> cartItems = cartProvider.cartItems;
    double total = 0;

    return Scaffold(
      backgroundColor: Color(0xff1a1a1a),
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "CheckOut >",
          style: GoogleFonts.dmSans(
            color: Colors.grey[200],
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          for (final item in cartItems)
            ListTile(
              title: Text(item.name,
                  style: GoogleFonts.dmSans(
                    color: Colors.grey[200],
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  )),
              subtitle: Text(item.brand,
                  style: GoogleFonts.dmSans(
                    color: Colors.grey[200],
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  )),
              trailing: Text('\$${item.price.toStringAsFixed(2)}',
                  style: GoogleFonts.dmSans(
                    color: Colors.grey[200],
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ListTile(
            title: const Text('Total:'),
            trailing: Text('\$${calculateTotal(cartItems).toStringAsFixed(2)}'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle the checkout process here, e.g., clear the cart and show a success message.
                cartProvider.clearCart();
                _showCheckoutSuccessDialog(context);
              },
              child: const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }

  double calculateTotal(List<ShoeItemData> cartItems) {
    double total = 0;
    for (final item in cartItems) {
      total += item.price;
    }
    return total;
  }

  Future<void> _showCheckoutSuccessDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Checkout Successful'),
          content: const Text('Thank you for your purchase!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class FavoritesProvider with ChangeNotifier {
  List<ShoeItemData> _favorites = [];

  List<ShoeItemData> get favorites => _favorites;

  void toggleFavorite(ShoeItemData shoe) {
    if (_favorites.contains(shoe)) {
      _favorites.remove(shoe);
    } else {
      _favorites.add(shoe);
    }
    notifyListeners();
  }

  void removeFromFavorites(ShoeItemData shoe) {
    if (_favorites.contains(shoe)) {
      _favorites.remove(shoe);
      notifyListeners();
    }
  }

  void clearFavorites() {
    _favorites.clear();
    notifyListeners();
  }
}

class CartProvider with ChangeNotifier {
  List<ShoeItemData> _cartItems = [];

  List<ShoeItemData> get cartItems => _cartItems;

  void addToCart(ShoeItemData shoe) {
    _cartItems.add(shoe);
    notifyListeners();
  }

  void removeFromCart(ShoeItemData shoe) {
    if (_cartItems.contains(shoe)) {
      _cartItems.remove(shoe);
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

class ShoeItemData {
  final String name;
  final String brand;
  final double price;
  final String image;

  ShoeItemData({
    required this.name,
    required this.brand,
    required this.price,
    required this.image,
  });
}
