Class {
	#name : #StMobilStopFinderPoint,
	#superclass : #StMobilAbstractEntity,
	#instVars : [
		'name',
		'type',
		'quality',
		'isBest',
		'id',
		'location',
		'coordinates',
		'object'
	],
	#category : #'SuedtirolMobilClient-Entity'
}

{ #category : #accessing }
StMobilStopFinderPoint class >> serializationProperties [
	^ {#name -> #name.
		#anyType -> #type.
		#quality -> #quality.
		#best -> #isBest.
		#stateless -> #id.
		#object -> #object.
		#ref -> #ref}
]

{ #category : #accessing }
StMobilStopFinderPoint >> coordinates [
	^ coordinates
]

{ #category : #accessing }
StMobilStopFinderPoint >> id [
	^ id
]

{ #category : #accessing }
StMobilStopFinderPoint >> id: anObject [
	id := anObject
]

{ #category : #accessing }
StMobilStopFinderPoint >> isBest [
	^ isBest
]

{ #category : #accessing }
StMobilStopFinderPoint >> isBest: anObject [
	isBest := anObject = '1'
]

{ #category : #accessing }
StMobilStopFinderPoint >> location [
	^ location
]

{ #category : #accessing }
StMobilStopFinderPoint >> name [
	^ name
]

{ #category : #accessing }
StMobilStopFinderPoint >> name: anObject [
	name := anObject
]

{ #category : #accessing }
StMobilStopFinderPoint >> object [
	^ object
]

{ #category : #accessing }
StMobilStopFinderPoint >> object: anObject [
	object := anObject
]

{ #category : #accessing }
StMobilStopFinderPoint >> quality [
	^ quality
]

{ #category : #accessing }
StMobilStopFinderPoint >> quality: anObject [
	quality := anObject asNumber
]

{ #category : #accessing }
StMobilStopFinderPoint >> ref: anObject [
	| coords |
	location := anObject at: 'place' ifAbsent: [ '' ].
	coords := anObject at: 'coords' ifAbsent: [ nil ].
	coords isEmptyOrNil ifTrue: [ ^ self ].
	coords := coords splitOn: $,.
	coordinates := G2DCoordinates x: coords first y: coords second
]

{ #category : #accessing }
StMobilStopFinderPoint >> type [
	^ type
]

{ #category : #accessing }
StMobilStopFinderPoint >> type: anObject [
	type := anObject asLowercase asSymbol
]
