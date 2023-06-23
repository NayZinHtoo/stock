import 'package:flutter/material.dart';

class StockListWidget extends StatefulWidget {
  const StockListWidget({super.key});

  @override
  State<StockListWidget> createState() => _StockListWidgetState();
}

class _StockListWidgetState extends State<StockListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [Text('You Chooose')],
        ),
        Row(
          children: [
            Card(
              elevation: 5.4,
              margin: const EdgeInsets.all(8),
              //shape:
              //RoundedRectangleBorder(borderRadius: BorderRadius.all(16 as Radius),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.4)),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        image: const DecorationImage(
                          image: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Flogowik.com%2Fflutter-vector-logo-5285.html&psig=AOvVaw1PpBihupsEZjIkXVjl6waj&ust=1687585200420000&source=images&cd=vfe&ved=0CA4QjRxqFwoTCPiAq_bW2P8CFQAAAAAdAAAAABAD'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListTile(
                          title: Text(
                            '',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Text(
                            '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
