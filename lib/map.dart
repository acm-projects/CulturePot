import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.509364, -0.128928),
        zoom: 9.2,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/nietztein/clugfq8n100vm01pd73p5gja0/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmlldHp0ZWluIiwiYSI6ImNsdWdhanh2aDExbXQybGs4bjl5bXhiMGkifQ.UxdetvpiP1FEXWB2XeTA4g',
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoibmlldHp0ZWluIiwiYSI6ImNsdWdhanh2aDExbXQybGs4bjl5bXhiMGkifQ.UxdetvpiP1FEXWB2XeTA4g',
            'id': 'mapbox.mapbox-streets-v8',
          },
          userAgentPackageName: 'com.example.culture_pot',
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () =>
                  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
      ],
    );
  }
}
