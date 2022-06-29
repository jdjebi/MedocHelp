import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const d_green = Color(0xFF54D3C2);

class MedocSection extends StatelessWidget {
  final List medocList = [
    {
      'title': 'medicament de dos',
      'place': 'wembley, London',
      'distance': 2,
      'review': 36,
      'picture': 'images/medicaments.jpg',
      'price': '180',
    },
  ];

  MedocSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fait en temps réel...',
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Plus',
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    const IconButton(
                      icon: Icon(
                        Icons.filter_list_outlined,
                        color: d_green,
                        size: 25,
                      ),
                      onPressed: null,
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(


            children: medocList.map((medoc) {
              return MedocCard(medoc);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class MedocCard extends StatelessWidget {
  final Map medocData;
  // ignore: use_key_in_widget_constructors
  const MedocCard(this.medocData);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 4,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 350,

            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),

              ),
              image: DecorationImage(
                image: AssetImage(
                  medocData['picture'],
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 5,
                  right: -15,
                  child: MaterialButton(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    onPressed: () {},
                    child: const Icon(
                      Icons.favorite_outline_rounded,
                      color: d_green,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         medocData['title'],
          //         style: GoogleFonts.nunito(
          //           fontSize: 18,
          //           fontWeight: FontWeight.w800,
          //         ),
          //       ),
          //       Text(
          //         '\$' + medocData['price'],
          //         style: GoogleFonts.nunito(
          //           fontSize: 18,
          //           fontWeight: FontWeight.w800,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         medocData['place'],
          //         style: GoogleFonts.nunito(
          //           fontSize: 14,
          //           color: Colors.grey[500],
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //       Row(
          //         children: [
          //           const Icon(
          //             Icons.place,
          //             color: d_green,
          //             size: 14.0,
          //           ),
          //           Text(
          //             medocData['distance'].toString() + ' km to city',
          //             style: GoogleFonts.nunito(
          //               fontSize: 14,
          //               color: Colors.grey[500],
          //               fontWeight: FontWeight.w400,
          //             ),
          //           ),
          //         ],
          //       ),
          //       Text(
          //         'per night',
          //         style: GoogleFonts.nunito(
          //           fontSize: 14,
          //           color: Colors.grey.shade800,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.fromLTRB(10, 3, 10, 0),
          //   child: Row(
          //     children: [
          //       Row(
          //         // ignore: prefer_const_literals_to_create_immutables
          //         children: [
          //           const Icon(
          //             Icons.star_rate,
          //             color: d_green,
          //             size: 14.0,
          //           ),
          //           const Icon(
          //             Icons.star_rate,
          //             color: d_green,
          //             size: 14.0,
          //           ),
          //           const Icon(
          //             Icons.star_rate,
          //             color: d_green,
          //             size: 14.0,
          //           ),
          //           const Icon(
          //             Icons.star_rate,
          //             color: d_green,
          //             size: 14.0,
          //           ),
          //           const Icon(
          //             Icons.star_border,
          //             color: d_green,
          //             size: 14.0,
          //           ),
          //         ],
          //       ),
          //       const SizedBox(width: 20),
          //       Text(
          //         medocData['review'].toString() + ' reviews',
          //         style: GoogleFonts.nunito(
          //           fontSize: 14,
          //           color: Colors.grey[500],
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}