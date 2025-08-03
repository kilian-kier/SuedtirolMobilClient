Class {
	#name : #StMobilPurchasedTrip,
	#superclass : #StMobilAbstractEntity,
	#instVars : [
		'id',
		'legs',
		'bike',
		'animal'
	],
	#category : #'SuedtirolMobilClient-Entity'
}

{ #category : #accessing }
StMobilPurchasedTrip class >> serializationProperties [
	^ {#id -> #id.
		#legs -> #legs.
		#bike -> #bike.
		#animal -> #animal}
]

{ #category : #accessing }
StMobilPurchasedTrip >> animal [
	^ animal
]

{ #category : #accessing }
StMobilPurchasedTrip >> animal: anObject [
	animal := anObject
]

{ #category : #accessing }
StMobilPurchasedTrip >> bike [
	^ bike
]

{ #category : #accessing }
StMobilPurchasedTrip >> bike: anObject [
	bike := anObject
]

{ #category : #actions }
StMobilPurchasedTrip >> cancel [
	^ (StMobilCancelTripRequest on: self client)
		trip: self;
		perform
]

{ #category : #accessing }
StMobilPurchasedTrip >> gtCancelAction: anAction [
	<gtAction>
	DateAndTime now
		> (DateAndTime fromString: (self legs first at: 'departure' at: 'time'))
		ifTrue: [ ^ anAction empty ].
	^ anAction button
		tooltip: 'Cancel this trip';
		priority: 1;
		icon: BrGlamorousIcons trash;
		action: [ :aButton | 
			self cancel.
			aButton phlow
				spawnObject: 'Trip has been canceled. TODO: refresh the phlow, without this message' ]
]

{ #category : #accessing }
StMobilPurchasedTrip >> id [
	^ id
]

{ #category : #accessing }
StMobilPurchasedTrip >> id: anObject [
	id := anObject
]

{ #category : #accessing }
StMobilPurchasedTrip >> legs [
	^ legs
]

{ #category : #accessing }
StMobilPurchasedTrip >> legs: anObject [
	legs := anObject
]
