Class {
	#name : #StMobilTripLeg,
	#superclass : #StMobilAbstractEntity,
	#instVars : [
		'duration',
		'points',
		'mode',
		'stopSequence'
	],
	#category : #'SuedtirolMobilClient-Entity'
}

{ #category : #accessing }
StMobilTripLeg class >> serializationProperties [
	^ {#timeMinute -> #duration.
		#points -> #points.
		#mode -> #mode.
		#stopSeq -> #stopSequence}
]

{ #category : #accessing }
StMobilTripLeg >> arrivalTimestamp [
	^ self destinationPoint timestamp
]

{ #category : #accessing }
StMobilTripLeg >> departurePlatform [
	^ self stopSequence first platformId
]

{ #category : #accessing }
StMobilTripLeg >> departurePoint [
	self assert: self points first usage = 'departure'.
	^ self points first
]

{ #category : #accessing }
StMobilTripLeg >> departureTimestamp [
	^ self departurePoint timestamp
]

{ #category : #accessing }
StMobilTripLeg >> destinationPlatform [
	^ self stopSequence last platformId
]

{ #category : #accessing }
StMobilTripLeg >> destinationPoint [
	self assert: self points last usage = 'arrival'.
	^ self points last
]

{ #category : #accessing }
StMobilTripLeg >> duration [
	^ duration
]

{ #category : #accessing }
StMobilTripLeg >> duration: anObject [
	duration := Duration minutes: anObject asNumber
]

{ #category : #accessing }
StMobilTripLeg >> mode [
	^ mode
]

{ #category : #accessing }
StMobilTripLeg >> mode: anObject [
	mode := StMobilTripMode on: anObject client: self client
]

{ #category : #accessing }
StMobilTripLeg >> points [
	^ points
]

{ #category : #accessing }
StMobilTripLeg >> points: anObject [
	points := anObject asOrderedCollection
			collect: [ :e | StMobilTripPoint on: e client: self client ]
]

{ #category : #accessing }
StMobilTripLeg >> stopSequence [
	^ stopSequence
]

{ #category : #accessing }
StMobilTripLeg >> stopSequence: anObject [
	stopSequence := anObject asOrderedCollection
			collect: [ :e | StMobilStopSequencePoint on: e client: self client ]
]
