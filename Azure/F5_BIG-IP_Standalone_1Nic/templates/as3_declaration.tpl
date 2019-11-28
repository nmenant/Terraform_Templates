{
  "class": "AS3",
  "action": "deploy",
  "persist": true,
  "declaration": {
    "class": "ADC",
    "schemaVersion": "3.0.0",
    "id": "fghijkl7890",
    "label": "Sample 1",
    "remark": "HTTP with custom persistence",
    "as3": {
      "class": "Tenant",
      "my-web-app": {
        "class": "Application",
        "template": "http",
        "serviceMain": {
          "class": "Service_HTTP",
          "virtualAddresses": [
           "${azure_F5_public_ip}"
          ],
          "pool": "web_pool",
          "persistenceMethods": [{
            "use": "jsessionid"
          }]
        },
        "web_pool": {
          "class": "Pool",
          "monitors": [
            "http"
          ],
          "members": [{
            "servicePort": 80,
            "serverAddresses": [
              "['${azure_f5_pool_members}']"
            ]
          }]
        },
        "jsessionid": {
          "class": "Persist",
          "persistenceMethod": "cookie",
          "cookieMethod": "hash",
          "cookieName": "JSESSIONID"
        }
      }
    }
  }
}