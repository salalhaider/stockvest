import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:FYPII/services/auth.dart';
import 'package:FYPII/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class Item {
  Item(this.name);
  final String name;
}

class _PredictionScreenState extends State<PredictionScreen> {
  final AuthService _auth = AuthService();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref('images/graph1.png');

  Item selectedCompany;
  Item selectedDays;
  Item selectedIndustry;
  Item selectedTemp;

  String confirmDate = '';
  String companyName = '';
  String predictMessage = '';
  String stockPrice = '';
  String numberOfDays = '';
  int numDays;
  String currStockPrice = '';
  String tempPrice = '';
  String fullCompName = '';
  String graph1URL = '';
  String graph2URL = '';
  String graph3URL = '';
  String companyCode = '';
  //String selectedIndustry = '';

  Future<void> uploadFile(String filePath) async {
    File file = File('C:/FYP II (FINAL)/FYPII/images/graph1.png');

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/graph1.png')
          .putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  createAlertDialog(BuildContext context, Widget stockWidget) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                '$fullCompName\nPREDICTIONS\nFOR THE NEXT $numberOfDays DAYS',
                style: TextStyle(fontFamily: 'Comfortaa'),
                textAlign: TextAlign.center,
              ),
              content: stockWidget,
              actions: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        FlatButton(
                            color: Colors.blueGrey[900],
                            child: Text('CLOSING PRICE GRAPH'),
                            onPressed: () async {
                              //File file1 = File('images/graph1.png');
                              //String file1 = 'images/graph1.png';
                              String filePath = 'C:/FYP II (FINAL)/FYPII/images/graph1.png';
                              uploadFile(filePath);

                              setState(() {
                                createGraphDialog(
                                    context,
                                    'CLOSING PRICES GRAPH',
                                    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg');
                              });
                            }),
                        SizedBox(width: 10.0),
                        FlatButton(
                            color: Colors.blueGrey[900],
                            child: Text('SMA GRAPH'),
                            onPressed: () {
                              setState(() {
                                createGraphDialog(
                                    context,
                                    'SIMPLE MOVING AVERAGES GRAPH',
                                    'images/graph2.png');
                              });
                            }),
                        SizedBox(width: 10.0),
                        FlatButton(
                            color: Colors.blueGrey[900],
                            child: Text('BOLLINGER BANDS GRAPH'),
                            onPressed: () {
                              setState(() {
                                createGraphDialog(
                                    context,
                                    'BOLLINGER BANDS GRAPH',
                                    'images/graph3.png');
                              });
                            }),
                        SizedBox(width: 10.0),
                        FlatButton(
                            color: Colors.blueGrey[900],
                            child: Text('CLOSE'),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
                  ),
                ),
              ]);
        });
  }

  createGraphDialog(BuildContext context, String graphTitle, String graphName) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                graphTitle,
                style: TextStyle(fontFamily: 'Comfortaa'),
                textAlign: TextAlign.center,
              ),
              content: Image.network(graphName),
              actions: [
                FlatButton(
                    color: Colors.blueGrey[900],
                    child: Text('CLOSE'),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]);
        });
  }

  List<String> stockStrings = [];
  List<Item> industryList = <Item>[];
  List<Item> tempList;

// Industry names

  List<Item> industryNames = <Item>[
    Item(
      'Cement',
    ),
    Item(
      'Automobile Assembler',
    ),
    Item(
      'Automobile Parts & Accessories',
    ),
    Item('Cable & Electrical Goods'),
    Item('Chemical'),
    Item('Commercial Banks'),
    Item('Engineering'),
    Item('Fertilizer'),
    Item('Food & Personal Care Products'),
    Item('Glass & Ceramics'),
    Item('Insurance'),
    Item('Leather & Tanneries'),
    Item('Oil & Gas Exploration Companies'),
    Item('Oil & Gas Marketing  Companies'),
    Item('Paper & Board'),
    Item('Pharmaceuticals'),
    Item('Power Generation & Distribution'),
    Item('Refinery'),
    Item('Sugar & Allied Industries'),
    Item('Technology & Communication'),
  ];

// Cement Companies

  List<Item> cement = <Item>[
    Item(
      'PSX/ACPL (Attock Cement)',
    ),
    Item(
      'PSX/BWCL (Bestway Cement)',
    ),
    Item(
      'PSX/CHCC (Cherat Cement)',
    ),
    Item(
      'PSX/DCL (Dewan Cement)',
    ),
    Item(
      'PSX/DBCI (Dadhaboy Cement)',
    ),
    Item(
      'PSX/DGKC (D.G Khan Cement)',
    ),
    Item(
      'PSX/FCCL (Fauji Cement)',
    ),
    Item(
      'PSX/FECTC (Fecto Cement)',
    ),
    Item(
      'PSX/DNCC (Dandot Cement)',
    ),
    Item(
      'PSX/FLYNG (Flying Cement)',
    ),
    Item(
      'PSX/GWLC (Gharibwal Cement)',
    ),
    Item(
      'PSX/JVDC (Javedan Corporation)',
    ),
    Item(
      'PSX/KOHC (Kohat Cement)',
    ),
    Item(
      'PSX/LUCK (Lucky Cement)',
    ),
    Item(
      'PSX/MLCF (Maple Leaf Cement)',
    ),
    Item(
      'PSX/PIOC (Pioneer Cement)',
    ),
    Item(
      'PSX/POWER (Power Cement)',
    ),
    Item(
      'PSX/SMCPL (Safe Mix Concrete)',
    ),
    Item(
      'PSX/THCCL (Thatta Cement)',
    ),
  ];

// Automobile Assembler Companies

  List<Item> automobile = <Item>[
    Item(
      'PSX/AGTL (Al Ghazi Tractors Limited)',
    ),
    Item(
      'PSX/ATLH (Atlas Honda Limited)',
    ),
    Item(
      'PSX/DFML (Dewan Farooque Motors Limited)',
    ),
    Item(
      'PSX/GHNI (Ghandhara Industries Ltd)',
    ),
    Item(
      'PSX/GHNL (Ghandhara Nissan Ltd)',
    ),
    Item(
      'PSX/GAIL (Ghani Automobile Industries Ltd)',
    ),
    Item(
      'PSX/HINO (Hino Pak Motor Limited)',
    ),
    Item(
      'PSX/HCAR (Honda Atlas Cars (Pak) Ltd)',
    ),
    Item(
      'PSX/INDU (Indus Motor Company Ltd)',
    ),
    Item(
      'PSX/MTL (Millat Tractors Limited)',
    ),
    Item(
      'PSX/PSMC (Pak Suzuki Motors Co Ltd)',
    ),
    Item(
      'PSX/SAZEW (Sazgar Engineering Works Ltd)',
    ),
  ];

  // Automobile Parts & Accessories companies

  List<Item> automobileParts = <Item>[
    Item(
      'PSX/AGIL (Agriautos Industries Co. Ltd.)',
    ),
    Item(
      'PSX/ATBA (Atlas Battery Ltd.)',
    ),
    Item(
      'PSX/BWHL (Baluchistan Wheels Ltd.)',
    ),
    Item(
      'PSX/EXIDE (Exide Pakistan Ltd.)',
    ),
    Item(
      'PSX/GTYR (General Tyre & Rubber Co.)',
    ),
    Item(
      'PSX/LOADS (Loads Limited.)',
    ),
    Item(
      'PSX/THALL (Thal Limited.)',
    ),
  ];

  // Cable and electrical goods companies

  List<Item> cableGoods = <Item>[
    Item(
      'PSX/EMCO (EMCO Industries Ltd.)',
    ),
    Item(
      'PSX/JOPP (Johnson & Philips (Pak) Ltd.)',
    ),
    Item(
      'PSX/PAEL (Pak Elektron Ltd.)',
    ),
    Item(
      'PSX/PCAL (Pakistan Cables Ltd.)',
    ),
    Item(
      'PSX/SIEM (Siemens (Pak) Eng. Co. Ltd.)',
    ),
    Item(
      'PSX/SING (WAVES Singer Pakistan Ltd.)',
    ),
  ];

  // Chemical companies

  List<Item> chemical = <Item>[
    Item(
      'PSX/AGL (Agritech Limited)',
    ),
    Item(
      'PSX/ARPL (Archroma Pakistan Limited)',
    ),
    Item(
      'PSX/BAPL (Bawany Air Products Limited)',
    ),
    Item(
      'PSX/BERG (Berger Paints Pakistan Limited)',
    ),
    Item(
      'PSX/BIFO (Bifo Industries Limited)',
    ),
    Item(
      'PSX/DOL (Descon Oxychem Limited)',
    ),
    Item(
      'PSX/DYNO (Dynea Pakistan Ltd)',
    ),
    Item(
      'PSX/EPCL (Engro Polymer & Chemicals Limited)',
    ),
    Item(
      'PSX/GGGLR (Ghani Global Holdings Limited - R)',
    ),
    Item(
      'PSX/ICI (I.C.I. Pakistan Limited)',
    ),
    Item(
      'PSX/ICL (Ittehad Chemicals Limited)',
    ),
    Item(
      'PSX/LPGL (Leiner Pak Gelatine Limited)',
    ),
    Item(
      'PSX/LOTCHEM (Lotte Chemical Pakistan Ltd XD)',
    ),
    Item(
      'PSX/NICL (Nimir Industrial Chemicals Limited)',
    ),
    Item(
      'PSX/NRSL (Nimir Resins Limited)',
    ),
    Item(
      'PSX/PAXOXY (Pakistan Oxygen Limited)',
    ),
    Item(
      'PSX/SARC (Sardar Chemical Industries Limited)',
    ),
    Item(
      'PSX/SITC (Sitara Chemicals Industries Limited)',
    ),
    Item(
      'PSX/SPL (Sitara Peroxide Limited)',
    ),
    Item(
      'PSX/WAHN (Wah-Noble Chemicals Ltd)',
    ),
  ];

// Bank companies

  List<Item> banks = <Item>[
    Item(
      'PSX/ABL (Allied Bank Limited)',
    ),
    Item(
      'PSX/AKBL (Askari Bank Limited)',
    ),
    Item(
      'PSX/BAHL (Bank Al Habib Ltd)',
    ),
    Item(
      'PSX/BAFL (Bank Alfalah Ltd)',
    ),
    Item(
      'PSX/BOP (Bank of Punjab)',
    ),
    Item(
      'PSX/FABL (Faysal Bank Limited)',
    ),
    Item(
      'PSX/HBL (Habib Bank Ltd)',
    ),
    Item(
      'PSX/HMB (Habib Metropolitan Bank Ltd)',
    ),
    Item(
      'PSX/JSBL (JS Bank Ltd)',
    ),
    Item(
      'PSX/MCB (MCB Bank Limited)',
    ),
    Item(
      'PSX/MEBL (Meezan Bank Limited)',
    ),
    Item(
      'PSX/NBP (National Bank of Pakistan)',
    ),
    Item(
      'PSX/SBL (Samba Bank Limited)',
    ),
    Item(
      'PSX/SNBL (Soneri Bank Limited)',
    ),
    Item(
      'PSX/SCBPL (Standard Chartered Bank Pak Ltd.)',
    ),
    Item(
      'PSX/SMBL (Summit Bank Limited)',
    ),
    Item(
      'PSX/BOK (The Bank of Khyber)',
    ),
    Item(
      'PSX/UBL (United Bank Limited)',
    ),
  ];

  // Engineering companies

  List<Item> engineering = <Item>[
    Item(
      'PSX/ADOS (Ados Pakistan Limited)',
    ),
    Item(
      'PSX/ASLPS (Aisha Steel Mils Conv Pre-Shares)',
    ),
    Item(
      'PSX/ASL (Aisha Steel Mills Limited)',
    ),
    Item(
      'PSX/ASTL (Amreli Steels Limited)',
    ),
    Item(
      'PSX/BCL (Bolan Castings Limited)',
    ),
    Item(
      'PSX/CSAP (Crescent Steel & Allied Products Limited)',
    ),
    Item(
      'PSX/DADX (Dadex Eternit Limited)',
    ),
    Item(
      'PSX/DSL (Dost Steels Limited)',
    ),
    Item(
      'PSX/ISL (International Steels Limited)',
    ),
    Item(
      'PSX/ITTEFAQ (Ittefaq Iron Industries Limited)',
    ),
    Item(
      'PSX/MSCL (Metropolitan Steel Corporation Limited)',
    ),
    Item(
      'PSX/MUGHAL (Mughal Iron & Steel Industries Limited)',
    ),
  ];

  // Fertilizer companies

  List<Item> fertilizer = <Item>[
    Item(
      'PSX/AHCL (Arif Habib Corporation Limited)',
    ),
    Item(
      'PSX/ASLPS (Aisha Steel Mils Conv Pre-Shares)',
    ),
    Item(
      'PSX/ENGRO (Engro Corporation Limited)',
    ),
    Item(
      'PSX/EFERT (Engro Fertilizers Limited)',
    ),
    Item(
      'PSX/FATIMA (Fatima Fertilizer Company Limited)',
    ),
    Item(
      'PSX/FFBL (Fauji Fertilizer Bin Qasim Limited)',
    ),
    Item(
      'PSX/FFC (Fauji Fertilizer Company Limited)',
    ),
  ];

  // Food & personal care companies

  List<Item> foodCare = <Item>[
    Item(
      'PSX/ASC (Al Shaheer Corporation Limited)',
    ),
    Item(
      'PSX/CLOV (Clover Pakistan Limited)',
    ),
    Item(
      'PSX/FFL (Fauji Foods Ltd)',
    ),
    Item(
      'PSX/GLPL (Gillette Pakistan Ltd)',
    ),
    Item(
      'PSX/MFL (Matco Foods Limited)',
    ),
    Item(
      'PSX/MFFL (Mitchells Fruit Farms Limited)',
    ),
    Item(
      'PSX/MUREB (Murree Brewery Company Limited)',
    ),
    Item(
      'PSX/NATF (National Foods Limited)',
    ),
    Item(
      'PSX/NESTLE (Nestle Pakistan Ltd.)',
    ),
    Item(
      'PSX/QUICE (Quice Food Industries Limited)',
    ),
    Item(
      'PSX/RMPL (Rafhan Maize Products)',
    ),
    Item(
      'PSX/SHEZ (Shezan International Limited)',
    ),
    Item(
      'PSX/SCL (Shield Corporation Limited)',
    ),
    Item(
      'PSX/TREET (Treet Corporation Limited)',
    ),
    Item(
      'PSX/ZIL (Zil Limited)',
    ),
  ];

// Glass & ceramics companies

  List<Item> glassCeramics = <Item>[
    Item(
      'PSX/BGL (Balochistan Glass Limited)',
    ),
    Item(
      'PSX/FRCL (Frontier Ceramics Limited)',
    ),
    Item(
      'PSX/GHGL (Ghani Glass Limited)',
    ),
    Item(
      'PSX/GGGL (Ghani Global Glass Limited)',
    ),
    Item(
      'PSX/GVGL (Ghani Value Glass Limited)',
    ),
    Item(
      'PSX/STCL (Shabbir Tiles & Ceramics Limited)',
    ),
    Item(
      'PSX/TGL (Tariq Glass Industries Limited)',
    ),
  ];

  // Insurance companies

  List<Item> insurance = <Item>[
    Item(
      'PSX/AICL (Adamjee Insurance Co Limited)',
    ),
    Item(
      'PSX/AGIC (Askari Gen Insurance)',
    ),
    Item(
      'PSX/ATIL (Atlas Insurance Limited)',
    ),
    Item(
      'PSX/CENI (Century Insurance Company Limited)',
    ),
    Item(
      'PSX/CSIL (Cresent Star Insurance Limited)',
    ),
    Item(
      'PSX/EFUG (EFU General Insurance Limited)',
    ),
    Item(
      'PSX/EWIC (East West Insurance Company Limited)',
    ),
    Item(
      'PSX/EFUL (EFU Life Assurance Limited)',
    ),
    Item(
      'PSX/HICL (Habib Insurance Company Limited)',
    ),
    Item(
      'PSX/IGIHL (IGI Holdings Limited)',
    ),
    Item(
      'PSX/IGIL (IGI Life Insurance Limited)',
    ),
    Item(
      'PSX/JGICL (Jubilee General Insurance Company Limited)',
    ),
    Item(
      'PSX/JLICL (Jubilee Life Insurance Company Limited)',
    ),
    Item(
      'PSX/RICL (Reliance Insurance Co. Limited)',
    ),
    Item(
      'PSX/SHNI (Shaheen Insurance Company Limited)',
    ),
    Item(
      'PSX/UNIC (The United Insurance Company)',
    ),
  ];

  // Leather & tanneries companies

  List<Item> leatherTanneries = <Item>[
    Item(
      'PSX/BATA (Bata Pakistan Ltd)',
    ),
    Item(
      'PSX/LEUL (Leather Up Limited)',
    ),
    Item(
      'PSX/SRVI (Service Industries Limited)',
    ),
  ];

  // Oil & gas exploration companies

  List<Item> oilExploration = <Item>[
    Item(
      'PSX/MARI (Mari Petroleum Company Limited)',
    ),
    Item(
      'PSX/OGDC (Oil & Gas Development Company Limited)',
    ),
    Item(
      'PSX/PPL (Pakistan Petroleum Limited)',
    ),
  ];

  // Oil & gas marketing companies

  List<Item> oilMarketing = <Item>[
    Item(
      'PSX/APL (Attock Petroleum Limited)',
    ),
    Item(
      'PSX/BPL (Burshane LPG Pakistan Limited)',
    ),
    Item(
      'PSX/HASCOL (Hascol Petroleum Limited)',
    ),
    Item(
      'PSX/HTL (Hi-Tech Lubricants Limited)',
    ),
    Item(
      'PSX/SHEL (Shell Pakistan Limited)',
    ),
    Item(
      'PSX/SNGP (Sui Northern Gas Pipelines Limited)',
    ),
    Item(
      'PSX/SSGC (Sui Southern Gas Company Limited)',
    ),
  ];

  // Paper & board companies

  List<Item> paperBoard = <Item>[
    Item(
      'PSX/CEPB (Century Paper & Board Mills Limited)',
    ),
    Item(
      'PSX/CPPL (Cherat Packaging Limited)',
    ),
    Item(
      'PSX/MERIT (Merit Packaging Limited)',
    ),
    Item(
      'PSX/PKGS (Packages Limited)',
    ),
    Item(
      'PSX/PPP (Pakistan Paper Products Limited)',
    ),
    Item(
      'PSX/RPL (Roshan Packages Limited)',
    ),
    Item(
      'PSX/SEPL (Security Papers Limited)',
    ),
  ];

  // Pharmaceutical companies

  List<Item> pharmaceuticals = <Item>[
    Item(
      'PSX/ABOT (Abbott Laboratories Pakistan Limited)',
    ),
    Item(
      'PSX/AGP (AGP Limited)',
    ),
    Item(
      'PSX/FEROZ (Ferozsons Laboratories Limited)',
    ),
    Item(
      'PSX/GSKCH (GlaxoSmithKline Consumer Healthcare)',
    ),
    Item(
      'PSX/GLAXO (GlaxoSmithKline Pakistan Limited)',
    ),
    Item(
      'PSX/HINOON (Highnoon Laboratories Limited)',
    ),
    Item(
      'PSX/IBLHL (IBL HealthCare Limited)',
    ),
    Item(
      'PSX/OTSU (Otsuka Pakistan Limited)',
    ),
    Item(
      'PSX/SAPL (Sanofi-Aventis Pakistan Limited)',
    ),
    Item(
      'PSX/SEARL (The Searle Company Limited)',
    ),
    Item(
      'PSX/WYETH (Wyeth Pakistan Limited)',
    ),
  ];

// Power generation & distribution companies

  List<Item> powerDistribution = <Item>[
    Item(
      'PSX/ALTN (Altern Energy)',
    ),
    Item(
      'PSX/AEL (Arshad Energy Limited)',
    ),
    Item(
      'PSX/EPQL (Engro Powergen Qadirpur Limited)',
    ),
    Item(
      'PSX/HUBC (The Hub Power Company Limited)',
    ),
    Item(
      'PSX/KEL (K-Electric Limited)',
    ),
    Item(
      'PSX/KOHP (Kohinoor Power Company Limited)',
    ),
    Item(
      'PSX/KAPCO (Kot Addu Power Company)',
    ),
    Item(
      'PSX/LPL (Lalpir Power Limited)',
    ),
    Item(
      'PSX/NCPL (Nishat Chunian Power Limited)',
    ),
    Item(
      'PSX/NPL (Nishat Power Limited)',
    ),
    Item(
      'PSX/PKGP (Pakgen Power Limited)',
    ),
    Item(
      'PSX/SPWL (Saif Power Limited)',
    ),
    Item(
      'PSX/TSPL (Tri-Star Power Limited)',
    ),
  ];

// Refinery companies

  List<Item> refineries = <Item>[
    Item(
      'PSX/ATRL (Attock Refinery Limited)',
    ),
    Item(
      'PSX/BYCO (Byco Petroleum Pakistan Limited)',
    ),
    Item(
      'PSX/NRL (National Refinery Limited)',
    ),
    Item(
      'PSX/PRL (Pakistan Refinery Limited)',
    ),
  ];

  // Sugar & allied industries companies

  List<Item> sugarAllied = <Item>[
    Item(
      'PSX/AGSML (Abdullah Shah Gazi Sugar Mills Ltd)',
    ),
    Item(
      'PSX/ADAMS (Adams Sugar Mills Limited)',
    ),
    Item(
      'PSX/AABS (Al-Abbas Sugar Mills Limited)',
    ),
    Item(
      'PSX/ALNRS (Al-Noor Sugar Mills Limited)',
    ),
    Item(
      'PSX/BAFS (Baba Farid Sugar Mills Limited)',
    ),
    Item(
      'PSX/CHAS (Chashma Sugar Mills Limited)',
    ),
    Item(
      'PSX/DWSM (Dewan Sugar Mills Limited)',
    ),
    Item(
      'PSX/HABSM (Habib Sugar Mills Limited)',
    ),
    Item(
      'PSX/HSM (Husein Sugar Mills Limited)',
    ),
    Item(
      'PSX/IMSL (Imperial Sugar Limited)',
    ),
    Item(
      'PSX/JSML (Jauharabad Sugar Mills Limited)',
    ),
    Item(
      'PSX/KPUS (Khairpur Sugar Mills Limited)',
    ),
    Item(
      'PSX/MRNS (Mehran Sugar Mills Limited)',
    ),
    Item(
      'PSX/MIRKS (Mirpurkhas Sugar Mills Limited)',
    ),
    Item(
      'PSX/SKRS (Sakrand Sugar Mills Limited)',
    ),
    Item(
      'PSX/SHSML (Shahmurad Sugar Mills Limited)',
    ),
    Item(
      'PSX/SHJS (Shahtaj Sugar Mills Limited)',
    ),
    Item(
      'PSX/SML (Shakarganj Limited)',
    ),
    Item(
      'PSX/SASML (Sindh Abadgars Sugar Mills Limited)',
    ),
    Item(
      'PSX/TICL (Thal Industries Corporation Ltd)',
    ),
  ];

  // Technology & communication companies

  List<Item> techCommunication = <Item>[
    Item(
      'PSX/AVN (Avanceon Limited)',
    ),
    Item(
      'PSX/HUMNL (Hum Network Limited)',
    ),
    Item(
      'PSX/MDTL (Media Times Limited)',
    ),
    Item(
      'PSX/NETSOL (NetSol Technologies Limited)',
    ),
    Item(
      'PSX/PAKD (Pak Datacom Limited)',
    ),
    Item(
      'PSX/SYS (Systems Limited)',
    ),
    Item(
      'PSX/TELE (Telecard Limited)',
    ),
    Item(
      'PSX/TPL (TPL Corp Limited)',
    ),
    Item(
      'PSX/TRG (TRG Pakistan Limited)',
    ),
    Item(
      'PSX/WTL (Worldcall Telecom Limited)',
    ),
  ];
  // Number of days for stock prediction

  List<Item> days = <Item>[
    Item(
      '30',
    ),
    Item(
      '60',
    ),
    Item(
      '90',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        automaticallyImplyLeading: true,
        title: Text('Stock Prediction'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                ),
                child: Center(
                  child: Text(
                    'Drawer',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
                leading: FaIcon(FontAwesomeIcons.home),
                title: Text('Home'),
                onTap: () => Navigator.popAndPushNamed(context, '/dashboard')),
            ListTile(
                leading: FaIcon(FontAwesomeIcons.chartBar),
                title: Text('Stock Prediction'),
                onTap: () => Navigator.popAndPushNamed(context, '/prediction')),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.pollH),
              title: Text('Market Summary'),
              onTap: () => Navigator.popAndPushNamed(context, '/marketSummary'),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.database),
              title: Text('Data Portal'),
              onTap: () => Navigator.popAndPushNamed(context, '/dataPortal'),
            ),
            ListTile(
                leading: FaIcon(FontAwesomeIcons.bullhorn),
                title: Text('PSX Announcements'),
                onTap: () =>
                    Navigator.popAndPushNamed(context, '/announcements')),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.newspaper),
              title: Text('Stock Market News'),
              onTap: () => Navigator.popAndPushNamed(context, '/marketNews'),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.guilded),
              title: Text('Investment Tips'),
              onTap: () =>
                  Navigator.popAndPushNamed(context, '/investmentTips'),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.penAlt),
              title: Text('Update Profile'),
              onTap: () => Navigator.popAndPushNamed(context, '/updateProfile'),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.idCard),
              title: Text('Contact Us'),
              onTap: () => Navigator.popAndPushNamed(context, '/contactUs'),
            ),
            ListTile(
                leading: FaIcon(FontAwesomeIcons.signOutAlt),
                title: Text('Sign Out'),
                onTap: () async {
                  await _auth.signOutFirebase();
                  Navigator.popAndPushNamed(context, '/login');
                }),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Image.asset(
                'images/data-analyze.jpg', //Image.asset('images/data-analyze.jpg',
                width: double.infinity,
                height: 200),
          ),

          // 1st selection (industry)
          Container(
            margin: EdgeInsets.only(top: 40.0),
            child: Text(
              'SELECT THE INDUSTRY: ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: DropdownButton<Item>(
              hint: Text("Select Industry"),
              value: selectedIndustry,
              onChanged: (Item value) {
                setState(() {
                  print(value.name);
                  selectedIndustry = value;
                  selectedCompany = selectedTemp;
                  predictMessage = '';
                  currStockPrice = '';
                  stockPrice = '';
                  stockStrings = [];
                });
              },
              items: industryNames.map((Item indNames) {
                return DropdownMenuItem<Item>(
                  value: indNames,
                  onTap: () {
                    setState(() {
                      if (indNames.name == 'Cement')
                        industryList = cement;
                      else if (indNames.name == 'Automobile Assembler')
                        industryList = automobile;
                      else if (indNames.name ==
                          'Automobile Parts & Accessories')
                        industryList = automobileParts;
                      else if (indNames.name == 'Cable & Electrical Goods')
                        industryList = cableGoods;
                      else if (indNames.name == 'Chemical')
                        industryList = chemical;
                      else if (indNames.name == 'Commercial Banks')
                        industryList = banks;
                      else if (indNames.name == 'Engineering')
                        industryList = engineering;
                      else if (indNames.name == 'Fertilizer')
                        industryList = fertilizer;
                      else if (indNames.name == 'Food & Personal Care Products')
                        industryList = foodCare;
                      else if (indNames.name == 'Glass & Ceramics')
                        industryList = glassCeramics;
                      else if (indNames.name == 'Insurance')
                        industryList = insurance;
                      else if (indNames.name == 'Leather & Tanneries')
                        industryList = leatherTanneries;
                      else if (indNames.name ==
                          'Oil & Gas Exploration Companies')
                        industryList = oilExploration;
                      else if (indNames.name == 'Oil & Gas Marketing Companies')
                        industryList = oilMarketing;
                      else if (indNames.name == 'Paper & Board')
                        industryList = paperBoard;
                      else if (indNames.name == 'Pharmaceuticals')
                        industryList = pharmaceuticals;
                      else if (indNames.name ==
                          'Power & Generation Distribution')
                        industryList = powerDistribution;
                      else if (indNames.name == 'Refinery')
                        industryList = refineries;
                      else if (indNames.name == 'Sugar & Allied Industries')
                        industryList = cableGoods;
                      else if (indNames.name == 'Technology & Communication')
                        industryList = techCommunication;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        indNames.name,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // 2nd selection (select company)
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              'SELECT THE COMPANY TO PREDICT THE STOCKS: ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Container(
              margin: EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
              child: DropdownButton<Item>(
                hint: Text("Select Company"),
                value: selectedCompany,
                onChanged: (Item value) {
                  setState(() {
                    predictMessage = '';
                    currStockPrice = '';
                    stockPrice = '';
                    selectedCompany = value;
                    stockStrings = [];
                  });
                },
                items: industryList.map((Item indList) {
                  return DropdownMenuItem<Item>(
                    value: indList,
                    onTap: () {
                      companyName = indList.name.toString();
                      companyCode = indList.name.toString();
                      fullCompName = companyName.substring(
                          companyName.indexOf('('), companyName.indexOf(')'));
                      fullCompName = fullCompName.replaceAll(')', '');
                      fullCompName = fullCompName.replaceAll('(', '');
                      fullCompName = fullCompName.toUpperCase();
                      companyName =
                          companyName.substring(0, companyName.indexOf(' '));

                      companyCode = companyCode.substring(
                        (companyCode.indexOf('/') + 1),
                        companyCode.indexOf(' '),
                      );

                      print(companyName);
                      print(companyCode);
                    },
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        indList.name,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // 3rd selection (number of days)
          Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                'SELECT THE NUMBER OF DAYS',
                style: TextStyle(color: Colors.black, fontSize: 14.0),
              )),
          Container(
            margin: EdgeInsets.only(top: 15.0),
            child: DropdownButton<Item>(
              hint: Text("Select Days"),
              value: selectedDays,
              onChanged: (Item value) {
                setState(() {
                  predictMessage = '';
                  stockPrice = '';
                  currStockPrice = '';
                  selectedDays = value;
                  stockStrings = [];
                });
              },
              items: days.map((Item days) {
                return DropdownMenuItem<Item>(
                  value: days,
                  onTap: () {
                    numberOfDays = days.name.toString();
                    numDays = int.parse(numberOfDays);
                    // print(numDays);
                  },
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        days.name,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0, bottom: 10.0),
            child: FlatButton(
                color: Colors.blueGrey[900],
                child: Text('PREDICT', style: buttonStyle),
                onPressed: () async {
                  print(companyCode);

                  // print(companyName);

                  final snackBar = SnackBar(
                    duration: Duration(seconds: 10),
                    content: Text(
                        'Communicating with the server. Results will be displayed shortly!'),
                    action: SnackBarAction(
                      label: '',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  //127.0.0.1 (LOCALHOST)
                  //10.0.2.2 (AVD EMULATORS)
                  // ngrok http 5000 to host on ngrok server on port 5000
                  // copy ngrok masked address for physical devices

                  final response1 = await http.post(
                    'http://10.0.2.2:5000/PREDICT',
                    body: json.encode({'name': companyName, 'days': numDays}),
                  );

                  /*
                  final response1 = await http.post(
                    'http://fyp2-stock-prediction.herokuapp.com/PREDICT',
                    body: json.encode({'name': companyName, 'days': numDays}),
                  );
                  */

                  final response2 =
                      await http.get('http://10.0.2.2:5000/PREDICT');

                  /* final response2 = await http.get(
                      'http://fyp2-stock-prediction.herokuapp.com/PREDICT'); */

                  final decoded =
                      json.decode(response2.body) as Map<String, dynamic>;

                  if (response2 != null) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  }

                  setState(() {
                    predictMessage = decoded['predict'];
                    currStockPrice = decoded['currPrice'];

                    predictMessage = predictMessage.toString();
                    predictMessage = predictMessage.replaceAll('[', '');
                    predictMessage = predictMessage.replaceAll(']', '');
                    predictMessage = predictMessage.replaceAll(' ', '');
                    stockStrings = predictMessage.split(',');
                    currStockPrice = currStockPrice.toString();

                    createAlertDialog(
                      context,
                      SingleChildScrollView(
                        child: Wrap(children: <Widget>[
                          Column(
                            children: [
                              if (currStockPrice != '')
                                Container(
                                  child: Table(
                                    border: TableBorder.all(
                                        width: 1.0, color: Colors.black),
                                    children: [
                                      TableRow(children: [
                                        Center(
                                          child: Text(
                                            'Current Price',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            currStockPrice,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              for (int index = 0;
                                  index < stockStrings.length;
                                  index++)
                                Container(
                                  child: Table(
                                    border: TableBorder.all(
                                        width: 1.0, color: Colors.black),
                                    children: [
                                      TableRow(children: [
                                        Center(
                                          child: Text(
                                            'After ${index + 1} days',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            '${stockStrings[index]}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                      ])
                                    ],
                                  ),
                                ),

                              //  for (var item in stockStrings) Text('1 days later: ($item)')

                              SizedBox(height: 20.0),
                            ],
                          )
                        ]),
                      ),
                    );
                  });

                  // print(predictMessage);
                }),
          ),
        ]),
      ),
    );
  }
}
