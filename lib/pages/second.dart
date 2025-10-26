import 'package:flutter/material.dart';
import 'package:flutter_fixed/attractions.dart';
import 'package:flutter_fixed/explore.dart';


class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 213, 143),

      //this app bar simply is reduced in size and given a black seperating divider

      //due to complications using column I have opted to using the custom scroll view
      //to display my body as I wanted a text widget along with the futureBuilder widget
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? const PortraitScrollView()
              : const LandscapeScrollView();
        },
      ),

    );
  }
}

class PortraitScrollView extends StatelessWidget {
  const PortraitScrollView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: ExploreCard(),
        ),
        FutureBuilder<List<Attraction>>(
          future: fetchAttractions(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    Attraction attraction = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 35),
                      
                      //this is where each attractions card is made
                      child: AttractionCard(attraction: attraction)
                    );
                  },
                  childCount: snapshot.data!.length,
                ),
              );
    
    
              
            } else if (snapshot.hasError) {
              return const SliverToBoxAdapter(
                child: Center(child: Text('An error was found in data extraction')),
              );
            } else {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        )
      ],
    );
  }
}


class LandscapeScrollView extends StatelessWidget {
  const LandscapeScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [

        const SliverToBoxAdapter(
          child: ExploreCard(),
        ),

        FutureBuilder<List<Attraction>>(
          future: fetchAttractions(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two cards per row
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    Attraction attraction = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),

                      //this is where each attractions card is made
                      child: AttractionCard(attraction: attraction)
                    );
                  },
                  childCount: snapshot.data!.length,
                ),
              );
            } else if (snapshot.hasError) {
              return const SliverToBoxAdapter(
                child: Center(child: Text('An error was found in data extraction')),
              );
            } else {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ],
    );
  }
}
