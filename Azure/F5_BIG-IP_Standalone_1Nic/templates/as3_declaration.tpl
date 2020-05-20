{
    "class": "AS3",
    "action": "deploy",
    "persist": true,
    "declaration": {
      "class": "ADC",
      "schemaVersion": "3.0.0",
      "id": "123abc",
      "label": "Sample 2",
      "remark": "HTTP with predictive-node pool",
      "Sample_02": {
        "class": "Tenant",
        "A1": {
          "class": "Application",
          "template": "http",
          "serviceMain": {
            "class": "Service_HTTP",
            "virtualAddresses": [
                "${azure_F5_public_ip}"
            ],
            "pool": "web_pool"
          },
          "web_pool": {
            "class": "Pool",
            "loadBalancingMode": "predictive-node",
            "monitors": [
              "http"
            ],
            "members": [{
              "servicePort": 80,
              "serverAddresses": [
                "${azure_f5_pool_members}"
              ]
            }]
          }
        }
      }
    }
  }
