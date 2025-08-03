Class {
	#name : #StMobilLoginRequest,
	#superclass : #StMobilAbstractRequest,
	#instVars : [
		'otp'
	],
	#category : #'SuedtirolMobilClient-Api'
}

{ #category : #accessing }
StMobilLoginRequest >> otp [
	^ otp
]

{ #category : #accessing }
StMobilLoginRequest >> otp: anObject [
	otp := anObject
]

{ #category : #actions }
StMobilLoginRequest >> request [
	^ self client
		postSPass: '/login/getMultiToken'
		withEntity: {'ticketNumber' -> self client ticketNumber.
				'oneTimePassword' -> self otp} asDictionary
]

{ #category : #actions }
StMobilLoginRequest >> serializationClass [
	^ StMobilLoginRespone
]
