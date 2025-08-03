Class {
	#name : #StMobilTripResponse,
	#superclass : #StMobilAbstractEntity,
	#instVars : [
		'origin',
		'destination',
		'timestamp',
		'trips',
		'timestampDepArr'
	],
	#category : #'SuedtirolMobilClient-Entity'
}

{ #category : #accessing }
StMobilTripResponse class >> serializationProperties [
	^ {#origin -> #origin.
		#destination -> #destination.
		#dateTime -> #dateTime.
		#trips -> #trips}
]

{ #category : #accessing }
StMobilTripResponse >> dateTime: anObject [
	| year month day hour minute |
	year := anObject at: 'year' ifAbsent: [ DateAndTime now year ].
	month := anObject at: 'month' ifAbsent: [ DateAndTime now month ].
	day := anObject at: 'day' ifAbsent: [ DateAndTime now dayOfMonth ].
	hour := anObject at: 'hour' ifAbsent: [ DateAndTime now hour ].
	minute := anObject at: 'minute' ifAbsent: [ DateAndTime now minute ].
	timestamp := DateAndTime
			year: year asNumber
			month: month asNumber
			day: day asNumber
			hour: hour asNumber
			minute: minute asNumber.
	timestampDepArr := anObject at: 'depparr' ifAbsent: [ 'dep' ]
]

{ #category : #accessing }
StMobilTripResponse >> destination [
	^ destination
]

{ #category : #accessing }
StMobilTripResponse >> destination: anObject [
	destination := StMobilStopFinderPoint
			on: (anObject
					at: 'points'
					at: 'point'
					ifAbsent: [ nil ])
			client: self client
]

{ #category : #views }
StMobilTripResponse >> gtTripsFor: aView [
	<gtView>
	self trips isEmptyOrNil ifTrue: [ ^ aView empty ].
	^ aView columnedList
		title: 'Trips';
		items: [ self trips ];
		column: 'Departure' text: [ :e | e legs first departurePoint name ];
		column: 'Departure time'
			text: [ :e | e legs first departureTimestamp asLocalStringYMDHM ];
		column: 'Destination' text: [ :e | e legs last destinationPoint name ];
		column: 'Arrival time'
			text: [ :e | e legs last arrivalTimestamp asLocalStringYMDHM ];
		column: 'Duration' text: #duration
]

{ #category : #accessing }
StMobilTripResponse >> origin [
	^ origin
]

{ #category : #accessing }
StMobilTripResponse >> origin: anObject [
	origin := StMobilStopFinderPoint
			on: (anObject
					at: 'points'
					at: 'point'
					ifAbsent: [ nil ])
			client: self client
]

{ #category : #accessing }
StMobilTripResponse >> timestamp [
	^ timestamp
]

{ #category : #accessing }
StMobilTripResponse >> trips [
	^ trips
]

{ #category : #accessing }
StMobilTripResponse >> trips: anObject [
	trips := anObject asOrderedCollection
			collect: [ :e | StMobilTrip on: e client: self client ]
]
