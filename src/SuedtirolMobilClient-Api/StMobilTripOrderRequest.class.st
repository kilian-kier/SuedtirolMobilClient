Class {
	#name : #StMobilTripOrderRequest,
	#superclass : #StMobilAbstractRequest,
	#instVars : [
		'trip'
	],
	#category : #'SuedtirolMobilClient-Api'
}

{ #category : #accessing }
StMobilTripOrderRequest >> legs [
	^ (self trip legs
		collect: [ :e | 
			{'departure'
					-> {'platform' -> e departurePlatform.
							'time' -> e departureTimestamp asIso8601.
							'name' -> e departurePoint name} asDictionary.
				'destination'
					-> {'platform' -> e destinationPlatform.
							'time' -> e arrivalTimestamp asIso8601.
							'name' -> e destinationPoint name} asDictionary.
				'mot'
					-> {'type' -> e mode type.
							'operator' -> e mode operator.
							'productId' -> e mode productId.
							'lineNumber' -> e mode lineNumber} asDictionary} asDictionary ]) asArray
]

{ #category : #actions }
StMobilTripOrderRequest >> request [
	^ self client
		postSPass: '/purchases/order'
		withEntity: {'data'
					-> {'legs' -> self legs.
							'bike' -> false.
							'animal' -> false} asDictionary.
				'token' -> self client token} asDictionary
]

{ #category : #accessing }
StMobilTripOrderRequest >> serializationClass [
	^ StMobilTripOrderResponse
]

{ #category : #accessing }
StMobilTripOrderRequest >> trip [
	^ trip
]

{ #category : #accessing }
StMobilTripOrderRequest >> trip: anObject [
	trip := anObject
]
