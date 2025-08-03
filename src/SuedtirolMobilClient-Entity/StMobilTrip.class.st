Class {
	#name : #StMobilTrip,
	#superclass : #StMobilAbstractEntity,
	#instVars : [
		'duration',
		'legs'
	],
	#category : #'SuedtirolMobilClient-Entity'
}

{ #category : #accessing }
StMobilTrip class >> serializationProperties [
	^ {#duration -> #duration.
		#legs -> #legs}
]

{ #category : #accessing }
StMobilTrip >> duration [
	^ duration
]

{ #category : #accessing }
StMobilTrip >> duration: anObject [
	| split |
	split := anObject splitOn: $:.
	duration := Duration minutes: split first asNumber * 60 + split second asNumber
]

{ #category : #actions }
StMobilTrip >> gtOrderAction: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Order this trip (TODO: better icon)';
		priority: 1;
		icon: BrGlamorousIcons accept;
		action: [ :aButton | aButton phlow spawnObject: (self client orderTrip: self) ]
]

{ #category : #accessing }
StMobilTrip >> legs [
	^ legs
]

{ #category : #accessing }
StMobilTrip >> legs: anObject [
	legs := anObject asOrderedCollection
			collect: [ :e | StMobilTripLeg on: e client: self client ]
]
