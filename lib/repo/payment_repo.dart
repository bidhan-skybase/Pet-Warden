import 'dart:convert';

import 'package:http/http.dart' as http;

class PaymentRepo {
  static Future payStackURLGen({
    required String email,
    required String amount,
    required Function(String authorizationUrl, String refrence) onSuccess,
    required Function(String message) onError,
  }) async {
    const url = "https://api.paystack.co/transaction/initialize";
    final response = await http.post(Uri.parse(url), body: {
      "email": email,
      "amount": amount,
      "currency": "NGN",
      "subaccount": "ACCT_6kbiumg0gnuu6zf",
      "bearer": "subaccount"
    }, headers: {
      "Authorization": "Bearer sk_test_812ce0748df3ccba6c3b803d8f75106f5961119c"
    });
    dynamic data = json.decode(response.body);
    if (data['status']) {
      var authorizationUrl = data["data"]["authorization_url"];
      var reference = data["data"]["reference"];
      onSuccess(authorizationUrl, reference);
    } else {
      onError(data['message']);
    }
  }

  static Future verifyTransaction({
    required String reference,
    required Function(bool status) onComplete,
  }) async {
    final url = "https://api.paystack.co/transaction/verify/$reference";

    var response = await http.get(Uri.parse(url), headers: {
      "Authorization":
          "Bearer sk_test_812ce0748df3ccba6c3b803d8f75106f5961119c" //secret key from Dashbord,
    });

    final data = jsonDecode(response.body);
    if (data["status"] == true) {
      if (data["data"]["status"] == "success") {
        onComplete(true);
      } else {
        onComplete(false);
      }
    } else {
      onComplete(false);
    }
  }
}
