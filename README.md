# SensorThings4R

## Introduction

The [OGC SensorThings API](http://developers.sensorup.com/docs/) is a web standard for wireless sensor networks (WSN) and aims to provide an interoperable, unified framework for handling sensor data. The standard is based on elements from [OGC Sensor Web Enablement (SWE)](http://www.opengeospatial.org/ogc/markets-technologies/swe), but is designed to provide interconnectivity between Internet of Things (IoT) devices, data and applications over the web. By implementing SensorThings into WSNs, developers don't have to worry about heterogeneity of devices, data formats and web protocols. Web development using standards facilitates easier data accessibility, higher interoperability, and eventually lowers the costs of sensor and gateway providers.


## Motivation

The motivation for creating an R implementation of the SensorThings API emerged from a project in the scope of the author's master thesis. The project includes making an IoT sensor network in an agricultural environment SensorThings compliant. Since R is one of the leading programming environments for statistics and data analysis, but also includes software development functionalities, the idea materialised to write a package that uses the SensorThingsAPI to import data from the web. After importing the data, they can be used for further analysis. Furthermore, an interactive data visualisation tool for displaying the sensor locations and the station details was created using the functions within the package.


## How it works

SensorThings API relies on a set of classes that are interrelated using web URLs. Starting at a base URL (e.g. [https://toronto-bike-snapshot.sensorup.com/v1.0](https://toronto-bike-snapshot.sensorup.com/v1.0)), API data can be accessed by adding parameters to it. sensorThings4R makes use of the concept by defining a set of functions that compile SensorThings URLs and various parameters, use these in a http request, parse the resulting JSON data and store them in R dataframes for further usage.
