Class {
	#name : #StMobilStopSequencePoint,
	#superclass : #StMobilTripPoint,
	#instVars : [
		'platformId'
	],
	#category : #'SuedtirolMobilClient-Entity'
}

{ #category : #accessing }
StMobilStopSequencePoint >> platformId [
	^ platformId
]

{ #category : #accessing }
StMobilStopSequencePoint >> ref: anObject [
	id := anObject at: 'id' ifAbsent: [ nil ].
	platformId := anObject at: 'zone' ifAbsent: [ nil ]
]
