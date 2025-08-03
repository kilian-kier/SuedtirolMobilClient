Class {
	#name : #StMobilAbstractRequest,
	#superclass : #Object,
	#instVars : [
		'client'
	],
	#category : #'SuedtirolMobilClient-Api'
}

{ #category : #'instance creation' }
StMobilAbstractRequest class >> on: aStMobilClient [
	^ self new setClient: aStMobilClient
]

{ #category : #accessing }
StMobilAbstractRequest >> client [
	^ client
]

{ #category : #actions }
StMobilAbstractRequest >> perform [
	| aResult |
	aResult := self request.
	aResult ifNil: [ ^ nil ].
	^ self serializationClass on: aResult client: self client
]

{ #category : #actions }
StMobilAbstractRequest >> request [
	^ self subclassResponsibility
]

{ #category : #accessing }
StMobilAbstractRequest >> serializationClass [
	^ self subclassResponsibility
]

{ #category : #private }
StMobilAbstractRequest >> setClient: aStMobilClient [
	client := aStMobilClient
]
