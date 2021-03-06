{
    "class": "ADC",
    "schemaVersion": "3.0.0",
    "id": "my-web-app-demo",
    "label": "app to demo AS3",
    "remark": "service generic to see VS name",
    "as3": {
        "class": "Tenant",
        "my_web_app": {
            "class": "Application",
            "template": "generic",
            "MyWebService": {
                "class": "Service_HTTP",
                "virtualAddresses": [
                    "${aws_F5_public_ip}"
                ],
                "virtualPort": 81,
                "pool": "websvc_pool"
            },
            "websvc_pool": {
                "class": "Pool",
                "monitors": [
                    {
                        "bigip": "/Common/gateway_icmp"
                    }
                ],
                "members": [
                    {
                        "servicePort": 80,
                        "serverAddresses": [
                            "${aws_f5_pool_members}"
                        ],
                        "shareNodes": true
                    }
                ]
            }
        }
    }
}