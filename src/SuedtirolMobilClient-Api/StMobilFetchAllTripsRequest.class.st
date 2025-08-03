Class {
	#name : #StMobilFetchAllTripsRequest,
	#superclass : #StMobilAbstractRequest,
	#category : #'SuedtirolMobilClient-Api'
}

{ #category : #actions }
StMobilFetchAllTripsRequest >> request [
	^ self client
		postSPass: '/purchases/getTravels'
		withEntity: {'token' -> self client token} asDictionary
]

{ #category : #accessing }
StMobilFetchAllTripsRequest >> serializationClass [
	^ StMobilTripListResponse
]
