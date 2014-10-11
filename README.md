## loopback-connector-saphana

`loopback-connector-saphana` is the [SAP HANA](http://www.saphana.com) connector module for [loopback-datasource-juggler](https://github.com/strongloop/loopback-datasource-juggler/).


## Connector settings

The connector can be configured using the following settings from the data source.
* host (default to 'localhost'): The host name or ip address of the SAP HANA server
* port (default to 30015): The port number of the SAP HANA server
* username: The user name to connect to the SAP HANA server
* password: The password
* debug (default to false)

**NOTE**: By default, the default schema of the user is used for all tables which is the same as the username.

The SAP HANA connector uses [node-hdb](https://github.com/SAP/node-hdb) as the driver. See more
information about configuration parameters, check [https://github.com/SAP/node-hdb/blob/master/README.md](https://github.com/SAP/node-hdb/blob/master/README.md).

## Discovering Models

SAP HANA data sources allow you to discover model definition information from existing SAP HANA databases. See the following APIs:

 - [dataSource.discoverModelDefinitions([username], fn)]
 - [dataSource.discoverSchema([owner], name, fn)]


## Model definition for SAP HANA

The model definition consists of the following properties:

* name: Name of the model, by default, it's the camel case of the table
* options: Model level operations and mapping to SAP HANA schema/table
* properties: Property definitions, including mapping to SAP HANA column

```json

    {"name": "Inventory", "options": {
      "idInjection": false,
      "hdb": {
        "schema": "strongloop",
        "table": "inventory"
      }
    }, "properties": {
      "id": {
        "type": "String",
        "required": false,
        "length": 64,
        "precision": null,
        "scale": null,
        "hdb": {
          "columnName": "id",
          "dataType": "varchar",
          "dataLength": 64,
          "dataPrecision": null,
          "dataScale": null,
          "nullable": "NO"
        }
      },
      "productId": {
        "type": "String",
        "required": false,
        "length": 20,
        "precision": null,
        "scale": null,
        "id": 1,
        "hdb": {
          "columnName": "product_id",
          "dataType": "varchar",
          "dataLength": 20,
          "dataPrecision": null,
          "dataScale": null,
          "nullable": "YES"
        }
      },
      "locationId": {
        "type": "String",
        "required": false,
        "length": 20,
        "precision": null,
        "scale": null,
        "id": 1,
        "hdb": {
          "columnName": "location_id",
          "dataType": "varchar",
          "dataLength": 20,
          "dataPrecision": null,
          "dataScale": null,
          "nullable": "YES"
        }
      },
      "available": {
        "type": "Number",
        "required": false,
        "length": null,
        "precision": 32,
        "scale": 0,
        "hdb": {
          "columnName": "available",
          "dataType": "integer",
          "dataLength": null,
          "dataPrecision": 32,
          "dataScale": 0,
          "nullable": "YES"
        }
      },
      "total": {
        "type": "Number",
        "required": false,
        "length": null,
        "precision": 32,
        "scale": 0,
        "hdb": {
          "columnName": "total",
          "dataType": "integer",
          "dataLength": null,
          "dataPrecision": 32,
          "dataScale": 0,
          "nullable": "YES"
        }
      }
    }}

```

## Type Mapping

 - Number
 - Boolean
 - String
 - Object
 - Date
 - Array

### JSON to SAP HANA Types

* String|JSON|Text|default: VARCHAR, default length is 1024
* Number: INTEGER
* Date: TIMESTAMP
* Timestamp: TIMESTAMP
* Boolean: VARCHAR(1)

### SAP HANA Types to JSON

* VARCHAR(1): Boolean
* VARCHAR|NVARCHAR|ALPHANUM|SHORTTEXT: String
* VARBINARY: Binary;
* TINYINT|SMALLINT|INTEGER|BIGINT|SMALLDECIMAL|DECIMAL|REAL|DOUBLE: Number
* DATE|TIME|SECONDDATE|TIMESTAMP: Date

## Destroying Models

Destroying models may result in errors due to foreign key integrity. Make sure
to delete any related models first before calling delete on model's with
relationships.

## Auto Migrate / Auto Update

After making changes to your model properties you must call `Model.automigrate()`
or `Model.autoupdate()`. Only call `Model.automigrate()` on new models
as it will drop existing tables.

LoopBack SAP HANA connector creates the following schema objects for a given
model:

* A table, for example, "product" under the default schema of the user
* A sequence with name "product_seq" if the primary key "id" is auto-increment


## Running tests

    npm test

* Prerequisites for saphana.discover.test.js: execute tables.sql in SAP HANA Studio