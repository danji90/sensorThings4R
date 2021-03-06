% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/locations.R
\name{senseLocations}
\alias{senseLocations}
\title{Loads Location data from SensorThings APIs}
\usage{
senseLocations(url)
}
\arguments{
\item{url}{A SensorThings API url (string!) containing the data in SensorThings web standard}
}
\value{
A "locationObject" dataframe containing data from url/Locations
}
\description{
This function parses Location SensorThings JSON data and stores it in an R data frame. Contains the complete Location data for further processing.
}
\examples{
x = senseLocations("https://toronto-bike-snapshot.sensorup.com/v1.0")
head(x)

\dontrun{
v = senseLocations("https://tasking-test.sensorup.com/v1.0")
v

a = senseLocations("http://example.sensorup.com/v1.0")
a
}
}
