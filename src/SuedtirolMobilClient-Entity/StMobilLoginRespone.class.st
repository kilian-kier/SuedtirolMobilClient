Class {
	#name : #StMobilLoginRespone,
	#superclass : #StMobilAbstractEntity,
	#instVars : [
		'token'
	],
	#category : #'SuedtirolMobilClient-Entity'
}

{ #category : #accessing }
StMobilLoginRespone class >> serializationProperties [
	^ {#sstToken -> #token}
]

{ #category : #accessing }
StMobilLoginRespone >> token [
	^ token
]

{ #category : #accessing }
StMobilLoginRespone >> token: anObject [
	token := anObject
]
