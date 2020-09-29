import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tido_herbz/src/pages/loading.dart';
import 'package:tido_herbz/src/pages/onlinepage.dart';
import 'package:tido_herbz/src/screens/main_screen.dart';
import 'package:async/async.dart';

import 'order_page.dart';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../widgets/order_card.dart';

List<String> ptaeastsuburbs = [
  'Alphen Park',
  'Arcadia',
  'Ashlea Gardens',
  'Bailey\'s Muckleneuk',
  'Brooklyn',
  'Brummeria',
  'Bryntirion',
  'Clydesdale',
  'Colbyn',
  'Constantia Park',
  'Die Wilgers',
  'Eastcliff',
  'Eastwood',
  'Elardus Park',
  'Equestria',
  'Erasmuskloof',
  'Erasmusrand',
  'Faerie Glen',
  'Garsfontein',
  'Groenkloof',
  'Hatfield',
  'Hazeldene',
  'Hazelwood',
  'Hillcrest',
  'Kilberry',
  'La Montagne',
  'Lukasrand',
  'Lydiana',
  'Lynnrodene',
  'Lynnwood',
  'Lynnwood Glen',
  'Lynnwood Manor',
  'Lynnwood Park',
  'Lynnwood Ridge',
  'Menlo Park',
  'Menlyn',
  'Meyerspark',
  'Monument Park',
  'Mooikloof',
  'Moreleta Park',
  'Muckleneuk',
  'Murrayfield',
  'New Muckleneuk',
  'Newlands',
  'Olympus',
  'Pretorius Park',
  'Pretoria East',
  'Rietvalleirand',
  'Shere',
  'Silver Lakes Estate',
  'Sterrewag',
  'Sunnyside',
  'Trevenna',
  'Val de Grace',
  'Wapadrand',
  'Waterkloof',
  'Waterkloof Glen',
  'Waterkloof Park',
  'Waterkloof Ridge',
  'Willow Glen',
  'Willow Park Manor',
  'Wingate Park',
  'Woodhill',
  'Woodlands',
  'Zwavelpoort'
];

List<String> montanasuburbs = [
  'Annlin',
  'Bellevue',
  'Bergtuin',
  'Deerness',
  'Derdepoort'
      'Derdepoort Park',
  'Despatch',
  'Doornpoort',
  'Eastlynne',
  'Eersterust',
  'Ekklesia',
  'Gezina',
  'Jan Niemand Park',
  'Kilner Park',
  'Koedoespoort',
  'Lyndopark',
  'Magalieskruin',
  'Mamelodi',
  'Montana',
  'Montana Park',
  'Montana Gardens',
  'Môregloed',
  'Nelmapius',
  'Queenswood',
  'Rietfontein',
  'Rietondale',
  'Riviera',
  'Silverton',
  'Silvertondale',
  'Sinoville',
  'Villieria',
  'Waltloo',
  'Waverley',
  'Weavind Park',
  'Wonderboom',
  'Wonderboom South'
];

List<String> centurionsuburbs = [
  'Amberfield',
  'Brakfontein',
  'Bronberrick',
  'Celtisdal',
  'Centurion',
  'Centurion Central',
  'Claudius',
  'Clubview',
  'Cornwall Hill',
  'De Hoewes',
  'Doringkloof',
  'Eldoraigne',
  'Erasmia',
  'Gerhardsville',
  'Hennopspark',
  'Heritage Hill',
  'Heuweloord',
  'Highveld',
  'Hoekplaats',
  'Irene',
  'Kloofsig',
  'Knoppieslaagte',
  'Kosmosdal',
  'Laezonia AH',
  'Laudium',
  'Louwlardia',
  'Lyttelton',
  'Lyttelton Manor',
  'Mnandi',
  'Monavoni',
  'Olievenhoutbosch',
  'Pierre van Ryneveld Park',
  'Pretoria Rural',
  'Raslouw',
  'Rooihuiskraal',
  'Rooihuiskraal North',
  'Skurweplaas',
  'Southdowns',
  'Sunderland Ridge',
  'Thaba Tshwane',
  'Thatchfield',
  'The Reeds',
  'Valhalla',
  'Vlakplaats',
  'Waterkloof 378-Jr',
  'Wierdapark',
  'Zwartkop'
];

List<String> midrandsuburbs = [
  'Airdlin',
  'Barbeque Downs Barbeque Downs Business Park',
  'Bloubosrand',
  'Blue Hills',
  'Broadacres',
  'Buccleuch',
  'Carlswald',
  'Chartwell',
  'Country View',
  'Crowthorne',
  'Dainfern',
  'Diepsloot',
  'Ebony Park',
  'Erand',
  'Farmall',
  'Glen Austin',
  'Halfway Gardens',
  'Halfway House Estate',
  'Headway Hill',
  'Houtkoppen',
  'Inadan',
  'Ivory Park',
  'Kya Sand',
  'Kya Sands',
  'Kyalami Agricultural Holdings',
  'Kyalami Business Park',
  'Kyalami Estates',
  'Maroeladal',
  'Midrand',
  'Midridge Park',
  'Millgate Farm',
  'Nietgedacht',
  'Noordwyk',
  'North Champagne Estates',
  'Paulshof',
  'Plooysville',
  'Rabie Ridge',
  'Randjesfontein AH',
  'Randjespark Riverbend AH',
  'Salfred',
  'Sunninghill',
  'Sunrella',
  'Trevallyn',
  'Trojan',
  'Vorna Valley',
  'Waterval City',
  'Willaway',
  'Witkoppen'
];

class PlaceOrderPage extends StatefulWidget {
  final itemstotal;
  final location;
  final place;
  final method;

  PlaceOrderPage({
    this.itemstotal,
    this.location,
    this.place,
    this.method,
  });

  @override
  _PlaceOrderPageState createState() => _PlaceOrderPageState();
}

class _PlaceOrderPageState extends State<PlaceOrderPage> {

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  int delfee = 0;
  int grandtotal = 0;
  int courierfee = 0;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final Firestore firestore = Firestore.instance;

  OrderPage orderPage = new OrderPage();

  emailBody(String name, String phonenumber, String useremail) {
    String email;
    String size;
    String gram;
    String color;
    String strain;
    String sizeword;
    String gramword;
    String colorword;
    String strainword;
    // print("name asseblief: " + _name);
    if(courierfee == 100){
      email = "<h4>COURIER ORDER:</h4>";
    }
    else{
      email = "<h4>YOUR ORDER:</h4>";
    }
    if (items.length > 0) {
      for (var item in items) {
        if (item.cartpage_prod_size != null) {
          size = item.cartpage_prod_size;
          sizeword = "Size: ";
        } else {
          size = "";
          sizeword = "";
        }
        if (item.cartpage_prod_gram != null) {
          gram = item.cartpage_prod_gram;
          gramword = "Grams: ";
        } else {
          gram = "";
          gramword = "";
        }
        if (item.cartpage_prod_color != null) {
          color = item.cartpage_prod_color;
          colorword = "Color: ";
        } else {
          color = "";
          colorword = "";
        }
        if (item.cartpage_prod_strain != null) {
          strain = item.cartpage_prod_strain;
          strainword = "Strain: ";
        } else {
          strain = "";
          strainword = "";
        }
        email += '<p><b>Item: </b>'+item.cartpage_prod_name +
            '</p>' +
            '<p><b>Price: </b>R' +
            item.cartpage_prod_price.toString() +
            '</p>' +
            '<p><b>'   +
            strainword +
            '</b>' +
            strain +
            '</p>' +
            '<p><b>'   +
            sizeword +
            '</b>' +
            size +
            '</p>' +
            '<p><b>' +
            gramword +
            '</b>' +
            gram +
            '</p>' +
            '<p><b>' +
            colorword +
            '</b>' +
            color +
            '</p>';
      }
      email += '<p>Courier Fee: R' +
          courierfee.toString() +
          '</p>'
          '<p>Delivery Fee: R' +
          delfee.toString() +
          '</p>'
          '<p><b>Total: R' +
          calculateGrandTotal().toString() +
          '</b></p>'
          '<p>Payment Method: ' +
          widget.method +
          '</p>'
          '<p>Address: ' +
          widget.place +
          '</p>'
          '<p>User: ' +
          name +
          '</p>'
          '<p>Email: ' +
          useremail +
          '</p>'
          '<p>Phone: ' +
          phonenumber +
          '</p>'
          '<br/>' +
          '<p><b>Tido Trips Team</b></p>';
      return email;
    }
    return "";
  }

  emailSetup(String _name, String _phonenumber) async {
    String username = "orders@tidotrips.com";
    String name = "Orders Tido Trips";
    String password = "TidoOrders321";

    FirebaseUser user = await firebaseAuth.currentUser();
    final smtpServer = gmail(username, password);
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(username,name)
      ..recipients.add(user.email) //recipent email
      ..bccRecipients.add(Address(username)) //bcc Recipents emails
      ..subject = 'TidoTrips Order (${DateTime.now()})' //subject of the email
      //..text = emailBody(_name, _phonenumber, user.email)
      ..html = emailBody(_name, _phonenumber, user.email);

    try {
      final sendReport = await send(message, smtpServer);

      print('Message sent: ' + sendReport.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("Success"),
              content: new Text("Your order has been placed"),
              actions: <Widget>[
                new MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) =>
                            MainScreen()));
                  },
                  child: new Text("close"),
                )
              ],
            );
          });
      items.clear();
      orderPage.resetCartTotal();
      //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n' +
          e.toString()); //print if the email is not sent
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("Failed"),
              content: new Text("Please try again shortly"),
              actions: <Widget>[
                new MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(context);
                  },
                  child: new Text("close"),
                )
              ],
            );
          });
    }
  }

  main() async {
    FirebaseUser user = await firebaseAuth.currentUser();

    String name;

    String phonenumber;

    bool _loader = true;

    if (_loader) {
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) => Loading()));
      firestore
          .collection("users")
          .document(user.uid)
          .get()
          .then((DocumentSnapshot result) => {
                setState(() {
                  name = result["name"];
                  phonenumber = result["phonenumber"];
                  _loader = false;
                  emailSetup(name, phonenumber);
                }),
              });
    }
  }

  int calculateDeliveryFee() {
    for (var i = 0; i < ptaeastsuburbs.length; i++) {
      if (widget.place.contains(ptaeastsuburbs[i]) &&
          widget.place.contains("Pretoria")) {
        delfee = 30;
        return delfee;
      }
    }
    for (var i = 0; i < montanasuburbs.length; i++) {
      if (widget.place.contains(montanasuburbs[i]) &&
          widget.place.contains("Pretoria")) {
        delfee = 50;
        return delfee;
      }
    }

    for (var i = 0; i < centurionsuburbs.length; i++) {
      if (widget.place.contains(centurionsuburbs[i]) &&
              widget.place.contains("Centurion") ||
          widget.place.contains(centurionsuburbs[i]) &&
              widget.place.contains("Pretoria")) {
        delfee = 70;
        return delfee;
      }
    }

    for (var i = 0; i < midrandsuburbs.length; i++) {
      if (widget.place.contains(midrandsuburbs[i]) &&
          widget.place.contains("Midrand")) {
        delfee = 70;
        return delfee;
      }
    }

    if (delfee == 0) {
      courierfee = 100;
    }

    return delfee;
  }

  int calculateGrandTotal() {
    grandtotal = widget.itemstotal + calculateDeliveryFee();
    if (courierfee == 100) {
      grandtotal = widget.itemstotal + courierfee;
    }
    return grandtotal;
  }

  @override
  Widget build(BuildContext context) {
    

    this._memoizer.runOnce(() async {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (courierfee == 100) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return new AlertDialog(
                  title: new Text("Note"),
                  content: new Text(
                      "Delivery is unavalaible in your area, courier fee will apply"),
                  actions: <Widget>[
                    new MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop(context);
                      },
                      child: new Text("close"),
                    )
                  ],
                );
              });
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        //title: Text('Payment ${widget.user.email}'),
        leading: BackButton(color: Colors.black),
        title: Text(
          "Place Order",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) => OrderPage()));
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Order Details",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Delivery Fee",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  Spacer(),
                  Text(
                    "R" + calculateDeliveryFee().toString(),
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Courier Fee",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  Spacer(),
                  Text(
                    "R" + courierfee.toString(),
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text(
                    "Items Total",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  Spacer(),
                  Text(
                    "R" + widget.itemstotal.toString(),
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text(
                    "Grand Total",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  Spacer(),
                  Text(
                    "R" + calculateGrandTotal().toString(),
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Text(
                    "Delivery address",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                width: 50.0,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      widget.place,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              ButtonTheme(
                minWidth: 200.0,
                child: RaisedButton(
                  onPressed: () {
                    /*if (courierfee == 100 ||//this is what I commented out, only had main()
                        widget.method == "Online Payment") {
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              OnlinePage()));
                    } else {*/
                    main();
                    //}
                  },
                  child: Text(
                    'Place Order',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
