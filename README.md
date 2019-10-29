# SAP-WebIDE-in-a-box

This image provides a trial version of SAP WebIDE.

## Motivation

Although there is an Orion-download for Windows and Mac available on tools.hana.ondemand.com, there may be cases where the installation (particularly on Mac) is erroneous.

## Prerequisites

By pulling or building this image, you accept the license agreement of the [SAP developer license, Version 3.1](https://tools.hana.ondemand.com/developer-license-3_1.txt)

## How to run it

```bash
docker run -p 8080:8080 -p 36295:36295 --network=sap --name sap-webide sap-webide:latest
```

If you need to connect to another system (which is not NPL running in the same docker network), you need to provide an own connection.
This can be done by either forking this repository or by creating the destination files (see [this sample](./destinations/NPL)) and then mounting them into the container when running it:

```bash
docker run ... <localFolder>:/opt/eclipse/config_master/service.destinations/destinations ...
```

Open a browser pointing it to http://localhost:8080/webide/index.html
You need to create an account on first use.

## Credits

- To Aydin Tekin for [his blog](https://blogs.sap.com/2017/04/25/how-to-run-sap-webide-personal-edition-on-linux/) letting me know how to run WebIDE on Linux.
- To Florian Henninger for [his blog](https://blogs.sap.com/2018/03/29/installing-sapwebide-personal-edition-and-connect-it-to-a-system/) on how to configure the WebIDE with respect to connections.
