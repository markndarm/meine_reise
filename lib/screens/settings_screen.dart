import 'package:flutter/material.dart';
import 'package:meine_reise/screens/add_trip.dart';
import 'package:meine_reise/screens/profile_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'dashboard_screen.dart';
import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("My Reise")),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                // anonyme und asynchrone Funktion
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle: TextStyle(color: Colors.black38),
          unselectedItemColor: Colors.green,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: DashboardScreen(),
                        type: PageTransitionType.bottomToTop
                    ),
                    //MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
                icon: Icon(Icons.home, color: Colors.green),
              ),
            ),
            BottomNavigationBarItem(
              label: "Add Trip",
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: AddTrip(),
                        type: PageTransitionType.bottomToTop
                    ),
                    //MaterialPageRoute(builder: (context) => AddTrip()),
                  );
                },
                icon: Icon(Icons.add_location_alt, color: Colors.green,),
                color: Colors.green,
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: ProfileScreen(),
                        type: PageTransitionType.bottomToTop
                    ),
                    //MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                icon: Icon(Icons.account_circle_rounded, color: Colors.green,),
                color: Colors.green,
              ),
            )          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Container( // Image Icon
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)) ,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("MyReise", style:
                    TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    ),
                  ),
                  Container(
                    // "Impressum"
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 32.0, right: 8.0, top: 30.0, bottom: 10.0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.green,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Imprint",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.green,
                              ),
                              width: double.infinity,
                              height: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SingleChildScrollView(
                                  child: Text(""
                                      "Imprint \n Angaben gemäß § 5 TMG \nMax Muster\nMusterweg\n12345 Musterstadt\nVertreten durch:\nMax Muster\nKontakt:\nTelefon: 01234-789456\nFax: 1234-56789\nE-Mail: max@muster.de\nRegistereintrag:\nEintragung im Registergericht: Musterstadt\nRegisternummer: 12345\nUmsatzsteuer-ID:\nUmsatzsteuer-Identifikationsnummer gemäß §27a Umsatzsteuergesetz: Musterustid.\nWirtschafts-ID:\nMusterwirtschaftsid\nAufsichtsbehörde:\nMusteraufsicht Musterstadt\nHaftungsausschluss:\nHaftung für Links\nUnser Angebot enthält Links zu externen Webseiten Dritter, auf deren Inhalte wir keinen Einfluss haben. Deshalb können wir für diese fremden Inhalte auch keine Gewähr übernehmen. Für die Inhalte der verlinkten Seiten ist stets der jeweilige Anbieter oder Betreiber der Seiten verantwortlich. Die verlinkten Seiten wurden zum Zeitpunkt der Verlinkung auf mögliche Rechtsverstöße überprüft. Rechtswidrige Inhalte waren zum Zeitpunkt der Verlinkung nicht erkennbar. Eine permanente inhaltliche Kontrolle der verlinkten Seiten ist jedoch ohne konkrete Anhaltspunkte einer Rechtsverletzung nicht zumutbar. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Links umgehend entfernen.\nUrheberrecht\nDie durch die Seitenbetreiber erstellten Inhalte und Werke auf diesen Seiten unterliegen dem deutschen Urheberrecht. Die Vervielfältigung, Bearbeitung, Verbreitung und jede Art der Verwertung außerhalb der Grenzen des Urheberrechtes bedürfen der schriftlichen Zustimmung des jeweiligen Autors bzw. Erstellers. Downloads und Kopien dieser Seite sind nur für den privaten, nicht kommerziellen Gebrauch gestattet. Soweit die Inhalte auf dieser Seite nicht vom Betreiber erstellt wurden, werden die Urheberrechte Dritter beachtet. Insbesondere werden Inhalte Dritter als solche gekennzeichnet. Sollten Sie trotzdem auf eine Urheberrechtsverletzung aufmerksam werden, bitten wir um einen entsprechenden Hinweis. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Inhalte umgehend entfernen.\nDatenschutz\nDie Nutzung unserer Webseite ist in der Regel ohne Angabe personenbezogener Daten möglich. Soweit auf unseren Seiten personenbezogene Daten (beispielsweise Name, Anschrift oder eMail-Adressen) erhoben werden, erfolgt dies, soweit möglich, stets auf freiwilliger Basis. Diese Daten werden ohne Ihre ausdrückliche Zustimmung nicht an Dritte weitergegeben.\nWir weisen darauf hin, dass die Datenübertragung im Internet (z.B. bei der Kommunikation per E-Mail) Sicherheitslücken aufweisen kann. Ein lückenloser Schutz der Daten vor dem Zugriff durch Dritte ist nicht möglich.\nDer Nutzung von im Rahmen der Impressumspflicht veröffentlichten Kontaktdaten durch Dritte zur Übersendung von nicht ausdrücklich angeforderter Werbung und Informationsmaterialien wird hiermit ausdrücklich widersprochen. Die Betreiber der Seiten behalten sich ausdrücklich rechtliche Schritte im Falle der unverlangten Zusendung von Werbeinformationen, etwa durch Spam-Mails, vor."
                                      "",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
