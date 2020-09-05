library firebase_dynamic_links_web;

import 'dart:async';
import 'dart:convert';
import 'dart:js';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:http/http.dart' as http;

class FirebaseDynamicLinksWebPlugin {

    static void registerWith(Registrar registrar) {
        final MethodChannel channel = MethodChannel(
            'plugins.flutter.io/firebase_dynamic_links',
            const StandardMethodCodec(),
            registrar.messenger
        );
        final FirebaseDynamicLinksWebPlugin instance = FirebaseDynamicLinksWebPlugin();
        channel.setMethodCallHandler(instance.handleMethodCall);
    }


    Future<dynamic> handleMethodCall(MethodCall call) async {
        switch (call.method) {
            case 'DynamicLinkParameters#buildUrl':
                return _buildUrl(call.arguments);
            case 'DynamicLinkParameters#shortenUrl':
                return _shortenUrl(call.arguments);
            case 'FirebaseDynamicLinks#getInitialLink':
                return _getInitialLink();
            default:
                throw PlatformException(
                    code: 'Unimplemented',
                    details: "The firebase_dynamic_links plugin for web doesn't implement "
                        "the method '${call.method}'");
        }
    }

    _getInitialLink() {
        return Completer().future;
    }

    _buildUrl(params) {
        return "${params["uriPrefix"]}?link=${params["link"]}&apn=${params["androidParameters"]["packageName"]}";
    }

    _shortenUrl(params) async {
        final apiKey = 'AIzaSyD_PbghcLOA1w1zj5UZtBqsc9FdjBY1DYQ';
        final url = 'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=${apiKey}';
        final body = {
            "longDynamicLink": params["url"],
            if (params["dynamicLinkParametersOptions"] != null ) "suffix": {
                "option": params["dynamicLinkParametersOptions"]["shortDynamicLinkPathLength"] == 0 ? "UNGUESSABLE" : "SHORT"
            }
        };
        final response = await http.post(url, body: json.encode(body));
        final shortLinkInfo = json.decode(response.body);
        return {
            "url": shortLinkInfo["shortLink"]
        };

    }
}