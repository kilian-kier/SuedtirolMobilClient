Class {
	#name : #StMobilTripRequest,
	#superclass : #StMobilAbstractRequest,
	#instVars : [
		'origin',
		'destination',
		'timestamp'
	],
	#category : #'SuedtirolMobilClient-Api'
}

{ #category : #accessing }
StMobilTripRequest >> destination [
	^ destination
]

{ #category : #accessing }
StMobilTripRequest >> destination: anObject [
	destination := anObject
]

{ #category : #accessing }
StMobilTripRequest >> origin [
	^ origin
]

{ #category : #accessing }
StMobilTripRequest >> origin: anObject [
	origin := anObject
]

{ #category : #actions }
StMobilTripRequest >> request [
	^ self client
		getEfa: '/web/XML_TRIP_REQUEST2'
		withQueryParameter: {'name_origin' -> self origin id.
				'type_origin' -> self origin type.
				'name_destination' -> self destination id.
				'type_destination' -> self destination type.
				'itdDateDay' -> self timestamp dayOfMonth.
				'itdDateMonth' -> self timestamp month.
				'itdDateYear' -> self timestamp year.
				'itdTimeHour' -> self timestamp hour.
				'itdTimeMinute' -> self timestamp minute.
				'odvSugMacro' -> true.
				'language' -> self client language.
				'outputFormat' -> 'JSON'.
				'outputEncoding' -> 'UTF-8'} asDictionary
]

{ #category : #accessing }
StMobilTripRequest >> serializationClass [
	^ StMobilTripResponse
]

{ #category : #accessing }
StMobilTripRequest >> timestamp [
	^ timestamp
]

{ #category : #accessing }
StMobilTripRequest >> timestamp: anObject [
	timestamp := anObject
]
