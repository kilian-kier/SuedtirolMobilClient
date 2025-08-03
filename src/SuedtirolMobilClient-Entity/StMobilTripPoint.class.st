Class {
	#name : #StMobilTripPoint,
	#superclass : #StMobilAbstractEntity,
	#instVars : [
		'name',
		'platformName',
		'location',
		'usage',
		'id',
		'timestamp'
	],
	#category : #'SuedtirolMobilClient-Entity'
}

{ #category : #accessing }
StMobilTripPoint class >> serializationProperties [
	^ {#name -> #name.
		#platformName -> #platformName.
		#place -> #location.
		#usage -> #usage.
		#dateTime -> #timestamp.
		#ref -> #ref}
]

{ #category : #accessing }
StMobilTripPoint >> id [
	^ id
]

{ #category : #accessing }
StMobilTripPoint >> location [
	^ location
]

{ #category : #accessing }
StMobilTripPoint >> location: anObject [
	location := anObject
]

{ #category : #accessing }
StMobilTripPoint >> name [
	^ name
]

{ #category : #accessing }
StMobilTripPoint >> name: anObject [
	name := anObject
]

{ #category : #accessing }
StMobilTripPoint >> platformName [
	^ platformName
]

{ #category : #accessing }
StMobilTripPoint >> platformName: anObject [
	platformName := anObject
]

{ #category : #accessing }
StMobilTripPoint >> ref: anObject [
	id := anObject at: 'id' ifAbsent: [ nil ]
]

{ #category : #accessing }
StMobilTripPoint >> timestamp [
	^ timestamp
]

{ #category : #accessing }
StMobilTripPoint >> timestamp: anObject [
	timestamp := DateAndTime
			date: (Date readFrom: (anObject at: 'date') pattern: 'dd.mm.yyyy')
			time: (Time readFromString: (anObject at: 'time'))
]

{ #category : #accessing }
StMobilTripPoint >> usage [
	^ usage
]

{ #category : #accessing }
StMobilTripPoint >> usage: anObject [
	usage := anObject
]
