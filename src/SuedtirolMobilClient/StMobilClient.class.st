Class {
	#name : #StMobilClient,
	#superclass : #Object,
	#instVars : [
		'ticketNumber',
		'token',
		'language'
	],
	#category : #SuedtirolMobilClient
}

{ #category : #accessing }
StMobilClient class >> defaultLanguage [
	^ 'de'
]

{ #category : #accessing }
StMobilClient class >> defaultTokenFile [
	^ FileLocator home / '.secrets' / 'suedtirol-mobil-token.txt'
]

{ #category : #'instance creation' }
StMobilClient class >> ticketNumber: aString [
	^ self new setTicketNumber: aString
]

{ #category : #'instance creation' }
StMobilClient class >> withTokenFromFile [
	^ self new setTokenFromFile: self defaultTokenFile
]

{ #category : #views }
StMobilClient >> activeTrips [
	^ self fetchTrips trips
		select: [ :e | 
			DateAndTime now
				>= (DateAndTime fromString: (e legs first at: 'departure' at: 'time'))
				and: [ DateAndTime now
						< (DateAndTime fromString: (e legs last at: 'destination' at: 'time')) ] ]
]

{ #category : #accessing }
StMobilClient >> efaStaUrl [
	^ 'https://efa.sta.bz.it' asZnUrl
]

{ #category : #actions }
StMobilClient >> fetchCustomerData [
	^ ZnClient new
		url: self sPassUrl / 'login' / 'getCustomerData';
		beOneShot;
		forJsonREST;
		entity: (ZnEntity json: (STONJSON toString: {'token' -> self token} asDictionary));
		post
]

{ #category : #actions }
StMobilClient >> fetchTicketNumber [
	^ ZnClient new
		url: self sPassUrl / 'login' / 'getTicketNumber';
		beOneShot;
		entity: (ZnEntity json: (STONJSON toString: {'token' -> self token} asDictionary));
		post
]

{ #category : #actions }
StMobilClient >> fetchTrips [
	^ (StMobilFetchAllTripsRequest on: self) perform
]

{ #category : #actions }
StMobilClient >> getEfa: aUrl withQueryParameter: aDictionary [
	| client |
	client := ZnClient new
			url: self efaStaUrl / aUrl;
			beOneShot;
			forJsonREST.
	client queryAddAll: aDictionary.
	^ client get
]

{ #category : #views }
StMobilClient >> gtActiveTripsFor: aView [
	<gtView>
	self isAuthenticated ifFalse: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Active Trips';
		priority: 3;
		items: [ self activeTrips ];
		column: 'Departure' text: [ :e | e legs first at: 'departure' at: 'name' ];
		column: 'Departure Time'
			text: [ :e | e legs first at: 'departure' at: 'time' ];
		column: 'Destination' text: [ :e | e legs last at: 'destination' at: 'name' ];
		column: 'Destination Time'
			text: [ :e | e legs last at: 'destination' at: 'time' ]
]

{ #category : #views }
StMobilClient >> gtCustomerDataFor: aView [
	<gtView>
	| customerData relevantData |
	self isAuthenticated ifFalse: [ ^ aView empty ].
	customerData := self fetchCustomerData.
	customerData isEmptyOrNil ifTrue: [ ^ aView empty ].
	relevantData := {'Name'
				-> ((customerData at: 'name' ifAbsent: [ '' ]) , ' '
						, (customerData at: 'surname' ifAbsent: [ '' ])).
			'Ticket Number' -> self ticketNumber.
			'Birthdate' -> (customerData at: 'birth_date' ifAbsent: [ '' ]).
			'Parking?' -> (customerData at: 'parking' ifAbsent: [ false ]).
			'Bicycle Box?' -> (customerData at: 'bicycle_box' ifAbsent: [ false ]).
			'Payment Method' -> (customerData at: 'payment_method' ifAbsent: [ '' ])}
			asOrderedDictionary.
	^ aView forward
		title: 'Customer Data';
		priority: 1;
		object: [ relevantData ];
		view: #gtLiveFor:
]

{ #category : #views }
StMobilClient >> gtPlannedTripsFor: aView [
	<gtView>
	self isAuthenticated ifFalse: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Planned Trips';
		priority: 4;
		items: [ self plannedTrips ];
		column: 'Departure' text: [ :e | e legs first at: 'departure' at: 'name' ];
		column: 'Departure Time'
			text: [ :e | e legs first at: 'departure' at: 'time' ];
		column: 'Destination' text: [ :e | e legs last at: 'destination' at: 'name' ];
		column: 'Destination Time'
			text: [ :e | e legs last at: 'destination' at: 'time' ]
]

{ #category : #views }
StMobilClient >> gtTripsFor: aView [
	<gtView>
	self isAuthenticated ifFalse: [ ^ aView empty ].
	^ aView columnedTree
		title: 'All Trips';
		priority: 2;
		items: [ self fetchTrips trips ];
		column: 'Departure' text: [ :e | e legs first at: 'departure' at: 'name' ];
		column: 'Departure Time'
			text: [ :e | e legs first at: 'departure' at: 'time' ];
		column: 'Destination' text: [ :e | e legs last at: 'destination' at: 'name' ];
		column: 'Destination Time'
			text: [ :e | e legs last at: 'destination' at: 'time' ]
]

{ #category : #accessing }
StMobilClient >> isAuthenticated [
	self ticketNumber ifNil: [ ^ false ].
	self token ifNil: [ ^ false ].	
	"^ self fetchTicketNumber = self ticketNumber"
	^ true
]

{ #category : #accessing }
StMobilClient >> language [
	^ language
]

{ #category : #actions }
StMobilClient >> loginWithOtp: aString [
	| response |
	response := (StMobilLoginRequest on: self)
			otp: aString;
			perform.
	response token ifNil: [ ^ false ].
	self token: response token.
	^ true
]

{ #category : #actions }
StMobilClient >> orderTrip: aStMobilTrip [
	^ (StMobilTripOrderRequest on: self)
		trip: aStMobilTrip;
		perform
]

{ #category : #views }
StMobilClient >> plannedTrips [
	^ self fetchTrips trips
		select: [ :e | 
			DateAndTime now
				< (DateAndTime fromString: (e legs first at: 'departure' at: 'time')) ]
]

{ #category : #actions }
StMobilClient >> postSPass: aUrl withEntity: aDictionary [
	| client |
	client := ZnClient new
			url: self sPassUrl / aUrl;
			beOneShot.
	client
		contentWriter: [ :data | ZnEntity json: (ZnUtils defaultJSONWriter toString: data) ].
	client contents: aDictionary.
	^ client post
]

{ #category : #printing }
StMobilClient >> printOn: aStream [
	aStream nextPutAll: self ticketNumber
]

{ #category : #accessing }
StMobilClient >> sPassUrl [
	^ 'https://spass.suedtirolmobil.info' asZnUrl
]

{ #category : #actions }
StMobilClient >> sendLoginOtpMail [
	self isAuthenticated ifTrue: [ ^ self ].
	^ self
		postSPass: '/login'
		withEntity: {'ticketNumber' -> self ticketNumber} asDictionary
]

{ #category : #private }
StMobilClient >> setTicketNumber: aString [
	ticketNumber := aString.
	language := self class defaultLanguage
]

{ #category : #private }
StMobilClient >> setTokenFromFile: aFileLocator [
	token := aFileLocator contents trimBoth.
	ticketNumber := self fetchTicketNumber.
	language := self class defaultLanguage
]

{ #category : #actions }
StMobilClient >> stopFinderForName: aString [
	^ (StMobilStopFinderRequest on: self)
		name: aString;
		perform
]

{ #category : #actions }
StMobilClient >> storeTokenInFile [
	self class defaultTokenFile ensureCreateFile.
	self class defaultTokenFile writeStream
		nextPutAll: self token;
		close
]

{ #category : #accessing }
StMobilClient >> ticketNumber [
	^ ticketNumber
]

{ #category : #accessing }
StMobilClient >> token [
	^ token
]

{ #category : #accessing }
StMobilClient >> token: aString [
	token := aString
]

{ #category : #actions }
StMobilClient >> tripFrom: aStStopFinderPoint to: aStStopFinderPoint2 at: aDateAndTime [
	^ (StMobilTripRequest on: self)
		origin: aStStopFinderPoint;
		destination: aStStopFinderPoint2;
		timestamp: aDateAndTime;
		perform
]
