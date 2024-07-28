import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testdb/screens/choose_product.dart';
import 'package:testdb/utility/app_controller.dart';
import 'package:testdb/utility/app_service.dart';

class BodyMap extends StatefulWidget {
  const BodyMap({super.key});

  @override
  State<BodyMap> createState() => _BodyMapState();
}

class _BodyMapState extends State<BodyMap> {
  Map<MarkerId, Marker> mapMarker = {};

  AppController controller = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    AppService().processFindPosition().then(
      (value) {
        print('## ${controller.positions.last}');
      },
    );

    createMarker();
  }

  Future<void> createMarker() async {
    double markerLat = 13.66963372332705;
    double markerLng = 100.62238678499472;

    BitmapDescriptor bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(64, 64)),
        'assets/images/icon48.png');

    MarkerId markerId = const MarkerId('shop1');
    Marker marker = Marker(
      markerId: markerId,
      position: LatLng(markerLat, markerLng),
      icon: bitmapDescriptor,
      onTap: () {
        Get.to(const ChooseProduct());
      },
    );

    mapMarker[markerId] = marker;
  }

  @override
  Widget build(BuildContext context) {
    return GetX<AppController>(
      init: AppController(),
      initState: (_) {},
      builder: (AppController appController) {
        return appController.positions.isEmpty
            ? const SizedBox()
            : GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                    target: LatLng(appController.positions.last.latitude,
                        appController.positions.last.longitude),
                    zoom: 16),
                markers: Set<Marker>.of(mapMarker.values),
              );
      },
    );
  }
}
