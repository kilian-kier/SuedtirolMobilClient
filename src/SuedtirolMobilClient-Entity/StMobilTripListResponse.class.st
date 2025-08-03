Class {
	#name : #StMobilTripListResponse,
	#superclass : #StMobilAbstractEntity,
	#instVars : [
		'trips'
	],
	#category : #'SuedtirolMobilClient-Entity'
}

{ #category : #'instance creation' }
StMobilTripListResponse class >> on: aString client: aStMobilClient [
	^ self new
		setRawData: (NeoJSONReader fromString: aString)
		client: aStMobilClient
]

{ #category : #private }
StMobilTripListResponse >> setRawData: anArray client: aStMobilClient [
	rawData := anArray.
	client := aStMobilClient.
	trips := anArray
			collect: [ :e | StMobilPurchasedTrip on: e client: aStMobilClient ]
]

{ #category : #accessing }
StMobilTripListResponse >> trips [
	^ trips
]
