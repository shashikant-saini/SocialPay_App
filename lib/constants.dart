import 'package:flutter/material.dart';
import 'widgets.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kDrawerTS = TextStyle(
  color: Colors.white,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 3.0,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
  ],
  fontSize: 15.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kInputDecor = InputDecoration(
  hintText: 'Enter your username',
  hintStyle: TextStyle(
    color: Color(0x99FFFFFF)
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);


final kBoxDecor = BoxDecoration(
  borderRadius: BorderRadius.circular(30.0),
  color: Colors.teal,
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 3,
      blurRadius: 7,
      offset: Offset(5, 5), // changes position of shadow
    ),
  ],
);


const credentials = r'''
  {
  "type": "service_account",
  "project_id": "socialpaydata",
  "private_key_id": "378954070ab969076e99f73c5846a27f8256d4b0",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCSfaZNmufOXFHV\nByspoAfoEKTFk416G09T6rGs3rXvYad9ArUeNWy3m2MSWF910HNAmKxW3h6sP9Vp\npPFICBDt8utmZrOoGp2HINu1i6rK6bPB1R66kgWJ3siOjTdYgFe0apd/1ydGLYlF\nyKyIadTurfGBFOaIdvnvvPCgpcCwwyWfKoDOYi31QME6NcrGKiH19ctMPpZp/oL+\nZZPrHBhMjGldR+zqzIKhC//4UhHlTmjvEcXH34znoQ6ObBDtbFirLIZKRHKa4aV9\nS2oyWyfMM4kmlNNtdDurTsEmnAEDm6L32YpmgSHdLENkBK+aRfb2/QMpWUsMM3zO\naxikv97FAgMBAAECggEACJ5jkEb6uB2euOxfjJGRoC8z1Ttdrwn39wV6Ek7WIHE7\n6Uh6qdOAg9BHb2xgosNdYeG5qLC6gu2Mhlcsf6Lt2roYlyFCv7Nf156bc/PK3CkM\n05d7joQ0gYyTJdlGy3+y6Uv+LDOB6DNEqM+U4GptmzoDrqcGpeUYxmifiwFwNAC9\nxyiDiw2EQkPT9IqMvstIXKql64KgweRjrxVxaCuFVWvI27o9bjas8ekyOzlFMJqa\nPaBHNYQ5jMCz2xs6T/oFs3SCTEYJX33axoL40tJmWhOyinxF1AfWrvWvuESuHccB\njT0UU1iZnhj8g12Z/H0rmAJ8Vhj/L5f7g85d/WrYAQKBgQDNWM22ZxeppuzJoel4\n+chGmzVT1tv9sL1mOQR1oKtKyV/VhqwTUkfX7zm3m7rDMJ2xZNKnzNxe0rK2FKg1\nftql5tcrPO0q9G4rDXtyhG7jaLjqgMAwbr+QiNknlUCNKYQnPqHzYyFVlLsRSfXA\nBeBoQ+y6GaRZncBFnLgYnwd8AQKBgQC2oDeKum7j+HQ9273ulaOye2Id1vft/jGS\nRvV2fHvKYn1qGTdrkyIj5nNXqNUGgDWc2JEZ5mEy87qYn7bQ+8w+vFoyVaG1Kdav\nS15Nfq47ytD3iSZx9Gdco2zYogz2LxxdC3ghb7AobyzvutI34vkwCIoJwAvgeR34\nkQOagsVyxQKBgEzlunNZ+9R+PCHtzh6Ne2Blcvzocw13iBWluHPMLRkefBLcEchS\ngbDtVvHZEYFSzVrG5NQNtWCVCnOBHNSboomJ/n2knTP+wNrCe74Qte3XI5g9irsY\nXghkFt3p2HiEWYbQv5kDQFJqFfuNdMfp63VgKmAuhgtBNeVboN0ngIgBAoGAQ9Qr\n7N2jlA5SdisoVvXDD+ZdocGW4hD4LmEmh/RiMd/0vrRQ7iZ+lqDgFB3DyR9TSkbx\nVZJIZZk6o7cmOmZbDK3+PhWp8tRwRTkT9GppohGJHXcWDVr+DN0x7x/4+nKy8Sfy\nXVDTN6FbKkrUCyfE738sbcSjZKL3a7vIf9m0JhUCgYEAvrX58Ef7EHRQcjtzRJyS\nWeqdAlDWXEI6NZcHFNdG/UWVLtsN7BATgBCYjdtLYWR3e7j6Ltka2Vf7XRyPynZm\nJ7+lOc1ElAaDkaTqWwOpaJkQeeleVBEEG5K1bYwbkhYvN110hesjIt4g1nSAvfLX\nXANBU2QERN8OsBPR7AtclRw=\n-----END PRIVATE KEY-----\n",
  "client_email": "socialpaydata@socialpaydata.iam.gserviceaccount.com",
  "client_id": "103238198173531707492",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/socialpaydata%40socialpaydata.iam.gserviceaccount.com"
  }
  ''';

const spreadsheetId = "1jk33XBdt2YHI26TAan1W0PhCr8Xmzed8_PHVzu3JyI0";

class DialogHelper{
  static exit(context) => showDialog(context: context, builder: (context) => dialogBox());
}





