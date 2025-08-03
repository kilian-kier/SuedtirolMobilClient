Class {
	#name : #StMobilCancelTripRequest,
	#superclass : #StMobilAbstractRequest,
	#instVars : [
		'trip'
	],
	#category : #'SuedtirolMobilClient-Api'
}

{ #category : #actions }
StMobilCancelTripRequest >> request [
	^ self client
		postSPass: '/purchases/cancel'
		withEntity: {'travelId' -> self trip id.
				'token' -> self client token} asDictionary
]

{ #category : #accessing }
StMobilCancelTripRequest >> trip [
	^ trip
]

{ #category : #accessing }
StMobilCancelTripRequest >> trip: anObject [
	trip := anObject
]
