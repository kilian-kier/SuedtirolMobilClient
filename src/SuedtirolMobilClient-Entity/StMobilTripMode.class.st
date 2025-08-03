Class {
	#name : #StMobilTripMode,
	#superclass : #StMobilAbstractEntity,
	#instVars : [
		'name',
		'product',
		'type',
		'destination',
		'operator',
		'productId',
		'lineNumber'
	],
	#category : #'SuedtirolMobilClient-Entity'
}

{ #category : #accessing }
StMobilTripMode class >> serializationProperties [
	^ {#name -> #name.
		#product -> #product.
		#type -> #type.
		#destination -> #destination.
		#diva -> #diva.
		#productId -> #productId}
]

{ #category : #accessing }
StMobilTripMode >> destination [
	^ destination
]

{ #category : #accessing }
StMobilTripMode >> destination: anObject [
	destination := anObject
]

{ #category : #accessing }
StMobilTripMode >> diva: anObject [
	operator := anObject at: 'operator' ifAbsent: [ nil ]
]

{ #category : #accessing }
StMobilTripMode >> lineNumber [
	^ lineNumber
]

{ #category : #accessing }
StMobilTripMode >> name [
	^ name
]

{ #category : #accessing }
StMobilTripMode >> name: anObject [
	name := anObject
]

{ #category : #accessing }
StMobilTripMode >> operator [
	^ operator
]

{ #category : #accessing }
StMobilTripMode >> product [
	^ product
]

{ #category : #accessing }
StMobilTripMode >> product: anObject [
	product := anObject
]

{ #category : #accessing }
StMobilTripMode >> productId [
	^ productId
]

{ #category : #accessing }
StMobilTripMode >> productId: anObject [
	productId := anObject asNumber
]

{ #category : #accessing }
StMobilTripMode >> type [
	^ type
]

{ #category : #accessing }
StMobilTripMode >> type: anObject [
	type := anObject asNumber.
	type = 6
		ifTrue: [ lineNumber := rawData at: 'trainType' ifAbsent: [  "trains"nil ] ]
		ifFalse: [ lineNumber := rawData at: 'number' ifAbsent: [ nil ] ]
]
