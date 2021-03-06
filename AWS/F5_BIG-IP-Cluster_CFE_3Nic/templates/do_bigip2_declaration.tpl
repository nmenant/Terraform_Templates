{
    "schemaVersion": "1.11.0",
    "class": "Device",
    "async": "true",
    "label": "my BIG-IP declaration for declarative onboarding",
    "Common": {
        "class": "Tenant",
        "myProvisioning": {
            "class": "Provision",
            "ltm": "nominal"
        },
        "myDns": {
            "class": "DNS",
            "nameServers": [
                "8.8.8.8"
            ],
            "search": [
                "f5.com"
            ]
        },
        "myNtp": {
            "class": "NTP",
            "servers": [
                "0.pool.ntp.org",
                "1.pool.ntp.org"
            ],
            "timezone": "UTC"
        },
        "external": {
            "class": "VLAN",
            "tag": 4094,
            "mtu": 1500,
            "interfaces": [
                {
                    "name": "1.1",
                    "tagged": false
                }
            ]
        },
        "external-self": {
            "class": "SelfIp",
            "address": "${aws_f5_public_ip}/24",
            "vlan": "external",
            "allowService": "default",
            "trafficGroup": "traffic-group-local-only"
        },
        "internal": {
            "class": "VLAN",
            "tag": 4093,
            "mtu": 1500,
            "interfaces": [
                {
                    "name": "1.2",
                    "tagged": false
                }
            ]
        },
        "internal-self": {
            "class": "SelfIp",
            "address": "${aws_f5_private_ip}/24",
            "vlan": "internal",
            "allowService": "default",
            "trafficGroup": "traffic-group-local-only"
        },
        "managementRoute": {
            "class": "ManagementRoute",
            "gw": "10.10.1.1",
            "network": "default",
            "mtu": 1500
        },
        "bigip1_internal_route": {
            "class": "Route",
            "gw": "10.10.21.1",
            "network": "10.10.20.0/24",
            "mtu": 1500
        },
        "configsync": {
    		"class": "ConfigSync",
    		"configsyncIp": "/Common/internal-self/address"
		},
		"failoverAddress": {
    		"class": "FailoverUnicast",
    		"address": "/Common/internal-self/address"
		}
    }
}