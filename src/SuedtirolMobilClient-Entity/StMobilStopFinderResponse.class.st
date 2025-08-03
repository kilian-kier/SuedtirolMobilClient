Class {
	#name : #StMobilStopFinderResponse,
	#superclass : #StMobilAbstractEntity,
	#instVars : [
		'points',
		'input'
	],
	#category : #'SuedtirolMobilClient-Entity'
}

{ #category : #accessing }
StMobilStopFinderResponse class >> serializationProperties [
	^ {#stopFinder -> #stopFinder}
]

{ #category : #accessing }
StMobilStopFinderResponse >> bestStop [
	| stop |
	stop := self stops select: [ :e | e isBest ].
	stop size = 1 ifTrue: [ ^ stop first ].
	^ self stops first
]

{ #category : #views }
StMobilStopFinderResponse >> gtStopsFor: aView [
	<gtView>
	self stops isEmptyOrNil ifTrue: [ ^ aView empty ].
	^ aView columnedList
		title: 'Stops';
		items: [ self stops ];
		column: 'Name' text: [ :e | e name ];
		column: 'Location' text: [ :e | e location ];
		column: 'Object' text: [ :e | e object ];
		column: 'Quality' text: [ :e | e quality ];
		column: 'is best?'
			iconName: [ :e | e isBest ifTrue: [ #glamorousAccept ] ifFalse: [ #glamorousCancel ] ]
]

{ #category : #accessing }
StMobilStopFinderResponse >> stopFinder: aDictionary [
	input := (aDictionary at: 'input' ifAbsent: [ '' ])
			at: 'input'
			ifAbsent: [ '' ].
	points := ((aDictionary at: 'points' ifAbsent: [ {} ]) asOrderedCollection
			collect: [ :e | StMobilStopFinderPoint on: e client: self client ])
			sort: [ :a :b | a quality > b quality ]
]

{ #category : #accessing }
StMobilStopFinderResponse >> stops [
	^ points select: [ :e | e type = #stop ]
]
