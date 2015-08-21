{
  "_id": "_design/default",
  "_rev": "37-3d36bf8e2c610a028e17e0a1682eec22",
  "language": "javascript",
  "views": {
    "byCollection_date": {
      "map": "function(doc) {\n  emit(doc.collection + \":\"+ doc.timestamp, doc);\n}"
    },
    "by_AdminDate": {
      "map": "    function (doc) {\n            emit(doc.savedBy + '|' + doc.lastModifiedAt);\n    }"
    },
    "by_AdminRegistration": {
      "map": "    function (doc) {\n        if (doc.serviceUuid &&  doc.question == 'Admin Registration') {\n            emit(doc.serviceUuid);\n        }\n    }"
    },
    "by_DocsDate": {
      "map": "    function (doc) {\n            emit(doc.lastModifiedAt);\n    }"
    },
    "byResult_date": {
      "map": "function(doc) {\nif (doc.collection == 'result') {\n  emit(doc.collection + \":\" + doc.question + \":\" + doc.createdAt, doc);\n}\n}"
    },
    "byResultIndivReg_date": {
      "map": "function(doc) {\nif (doc.collection == 'result') {\nif (doc.question == \"Individual Registration\") {\n  emit(doc.collection + \":\"+ doc.createdAt, doc);\n}\n}\n}"
    },
    "byResultTrichiasis_date": {
      "map": "function(doc) {\nif (doc.collection == 'result') {\nif (doc.question == \"Trichiasis Surgery\") {\n  emit(doc.collection + \":\"+ doc.createdAt, doc);\n}\n}\n}"
    },
    "by_AdminRegistrationDate": {
      "map": "    function (doc) {\n        if (doc.question == 'Admin Registration') {\n            emit(doc.lastModifiedAt, doc);\n        }\n    }"
    }
  },
  "updates": {
    "in-place-query": "function(doc, req){var field = req.query.field;var value = req.query.value;var message = 'set '+field+' to '+value;doc[field] = value;return [doc, message];}",
    "latlong-query": "function(doc, req){var lat = req.query.lat;var long = req.query.long;var message = 'set lat to '+lat+' and long to '+long;doc['lat'] = lat;doc['long'] = long;return [doc, message];}",

}
