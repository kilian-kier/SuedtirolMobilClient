Class {
	#name : #StMobilStopFinderRequest,
	#superclass : #StMobilAbstractRequest,
	#instVars : [
		'name'
	],
	#category : #'SuedtirolMobilClient-Api'
}

{ #category : #accessing }
StMobilStopFinderRequest >> name [
	^ name
]

{ #category : #accessing }
StMobilStopFinderRequest >> name: anObject [
	name := anObject
]

{ #category : #actions }
StMobilStopFinderRequest >> request [
	^ self client
		getEfa: '/web/XML_STOPFINDER_REQUEST'
		withQueryParameter: {'name_sf' -> self name.
				'locationServerActive' -> 1.
				'stateless' -> 1.
				'odvSugMacro' -> true.
				'language' -> self client language.
				'outputFormat' -> 'JSON'.
				'outputEncoding' -> 'UTF-8'} asDictionary
]

{ #category : #accessing }
StMobilStopFinderRequest >> serializationClass [
	^ StMobilStopFinderResponse
]
