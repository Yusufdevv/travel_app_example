import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewLocationImage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.grey,
          )),
          alignment: Alignment.center,
          child: _previewLocationImage == null
              ? const Text('Manzil tanlanmadi.')
              : Image.network(_previewLocationImage!),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.location_on),
              label: const Text('Mening manzilim'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Xaritani ochish'),
            ),
          ],
        )
      ],
    );
  }
}
