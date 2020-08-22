import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qartfashion/components/product_tile.dart';
import 'package:qartfashion/components/product_box.dart';
import 'package:qartfashion/constants/constant.dart';
import 'package:qartfashion/screens/productDetail_screen.dart';
import 'package:qartfashion/services/database_service.dart';
import 'package:qartfashion/services/network_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MainScreen extends StatefulWidget {
  final bool first;
  MainScreen({this.first = false});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  AnimationController searchBarController, qrScannerController;
  TextEditingController searchController = TextEditingController();
  List productList = [];
  List searchResults = [];

  // QR CODE SCANNER DATA
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  QRViewController controller;
  bool isQrRunning = false;
  bool isQrScanOpen = false;

  // SEARCH BAR DATA
  bool isSerachBarOpen = false;

  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    searchBarController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    qrScannerController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    loadDataFromNetword();

    super.initState();
  }
  
  @override
  void dispose() {
    qrScannerController.dispose();
    searchController.dispose();
    super.dispose();
  }

    void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      searchController.text = scanData;
      revertQrScanner();
      controller.pauseCamera();
      setState(() {
        isQrRunning = false;
        isQrScanOpen = false;
      });
    });
  }

  void loadDataFromNetword() async {
    NetworkService networkService = NetworkService();
    var data = await networkService.getData();
    for (var item in data) {
      setState(() {
        productList.add(item);
      });
    }
    databaseService.saveData(data);
  }

  Future<Null> onRefresh() async {
    loadDataFromNetword();
    await Future.delayed(Duration(seconds: 2), () {});
    return null;
  }

  void bringSearchBar() {
    searchBarController.forward(from: 0.0);
    searchBarController.addListener(() {

    });
  }

  void revertSearchBar() {
    searchBarController.reverse(from: 1.0);
    searchBarController.addListener(() {

    });
  }

  void bringQrScanner() {
    qrScannerController.forward(from: 0.0);
    qrScannerController.addListener(() {
//      setState(() {
//      });
    });
  }

  void revertQrScanner() {
    qrScannerController.reverse(from: 1.0);
    qrScannerController.addListener(() {
//      setState(() {
//      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 80.0,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 2.0,
                        color: Colors.blueGrey.shade200)
                  ]),
                  child: Column(
                    children: [
                      Container(
                        height: 30.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                print(await databaseService.countData());
                              },
                              child: Text(
                                'QART',
                                style: KCardHeadingTextStyle,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.select_all),
                              onPressed: () {
                                setState(() {
                                  isQrRunning = true;
                                });
                                if(!isQrScanOpen){
                                  controller.resumeCamera();
                                  bringQrScanner();
                                  isQrScanOpen = true;
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 40.0,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Container(
                                child: TextField(
                                  controller: searchController,
                                  decoration:
                                      InputDecoration(hintText: 'Search item'),
                                  onTap: () {
                                    if(!isSerachBarOpen){
                                      bringSearchBar();
                                      isSerachBarOpen = true;
                                    }
                                  },
                                  onChanged: (val) async {
                                    var data = await databaseService
                                        .findDataByName(val);
                                    print(data);
                                    setState(() {
                                      searchResults = data;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    if(!isSerachBarOpen){
                                      bringSearchBar();
                                      isSerachBarOpen = true;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                productList.length == 0
                    ? Expanded(
                        child: Container(
                            child: Center(
                        child: CupertinoActivityIndicator(),
                      )))
                    : Expanded(
                        child: RefreshIndicator(
                          color: KThemeBlueColor,
                          strokeWidth: 5.0,
                          backgroundColor: Colors.white,
                          displacement: 10.0,
                          onRefresh: onRefresh,
                          child: Container(
                            child: GridView.builder(
                              itemCount: productList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return ProductBox(
                                  imageURL: productList[index]['ImageUrl'],
                                  productCategory: productList[index]
                                      ['Category'],
                                  productPrice: productList[index]['MRP'],
                                  productSubCategory: productList[index]
                                      ['SubCategory'],
                                  onTap: () {
                                    if(isQrScanOpen){
                                      revertQrScanner();
                                      isQrScanOpen = false;
                                    }else{
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                            return ProductDetail(
                                              productData: productList[index],
                                              searchedData: false,
                                            );
                                          }));
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      )
              ],
            ),
            Positioned(
              top: 80.0,
              child: AnimatedBuilder(
                animation: searchBarController,
                builder: (context,child){
                 return Transform(
                   transform: Matrix4.identity()
                     ..translate(
                         0.0,
                         MediaQuery.of(context).size.height -
                             searchBarController.value *
                                 MediaQuery.of(context).size.height),
                   child: Container(
                     width: MediaQuery.of(context).size.width,
                     height: MediaQuery.of(context).size.height*.87,
                     color: Colors.white,
                     child: Column(
                       children: [
                         Container(
                           alignment: Alignment.centerRight,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                 child: Text('Search results',style: KCardSubHeadingTextStyle,),
                               ),
                               IconButton(
                                 icon: Icon(
                                   Icons.expand_more,
                                   color: Colors.black,
                                 ),
                                 onPressed: () {
                                   searchController.clear();
                                   revertSearchBar();
                                   isSerachBarOpen = false;
                                 },
                               ),
                             ],
                           ),
                         ),
                         Expanded(
                           child: Container(
                             child: ListView.builder(
                               itemCount: searchResults.length,
                               itemBuilder: (context, index) {
                                 return GestureDetector(
                                   onTap: (){
                                     Navigator.push(context,MaterialPageRoute(builder: (context){
                                       return ProductDetail(productData: searchResults[index],);
                                     }));
                                   },
                                   child: ProductTile(
                                     imageUrl: searchResults[index]['ImageUrl'],
                                     name: searchResults[index]['SubCategory'],
                                     sizes: searchResults[index]['AvailableSizes'],
                                     price: searchResults[index]['MRP'].toString(),
                                   ),
                                 );
                               },
                             ),
                           ),
                         )
                       ],
                     ),
                   ),
                 );
                }
              ),
            ),
            Center(
              child: AnimatedBuilder(
                  animation: qrScannerController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: qrScannerController.value,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(
                              0.0, -700.0 + qrScannerController.value * 700),
                        child: Container(
                          height: 300.0,
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: KStandardBoxShadow
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'SCAN QR',
                                    style: KCardHeadingTextStyle,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.keyboard_arrow_up),
                                    color: Colors.black,
                                    onPressed: () {
                                      isQrScanOpen = false;
                                      controller.pauseCamera();
                                      revertQrScanner();
                                    },
                                  )
                                ],
                              ),
                              isQrRunning==false?Container():Expanded(
                                flex: 5,
                                child: QRView(
                                  key: qrKey,
                                  onQRViewCreated: _onQRViewCreated,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
