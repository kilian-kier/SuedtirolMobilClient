Class {
	#name : #StMobilAbstractEntity,
	#superclass : #Object,
	#instVars : [
		'rawData',
		'client'
	],
	#category : #'SuedtirolMobilClient-Entity'
}

{ #category : #'instance creation' }
StMobilAbstractEntity class >> on: aDictionary client: aStMobilClient [
	^ self new setRawData: aDictionary client: aStMobilClient
]

{ #category : #accessing }
StMobilAbstractEntity class >> serializationProperties [
	^ self subclassResponsibility
]

{ #category : #accessing }
StMobilAbstractEntity >> client [
	^ client
]

{ #category : #private }
StMobilAbstractEntity >> setRawData: aDictionary client: aStMobilClient [
	((aDictionary isKindOf: Dictionary)
		or: [ aDictionary isKindOf: OrderedDictionary ])
		ifTrue: [ rawData := aDictionary ]
		ifFalse: [ rawData := NeoJSONReader fromString: aDictionary ].
	client := aStMobilClient.
	rawData isEmptyOrNil ifTrue: [ ^ self ].
	self class serializationProperties
		do: [ :aPair | 
			(rawData includesKey: aPair key)
				ifTrue: [ self
						perform: aPair value asSymbol asMutator
						withArguments: {rawData at: aPair key asString ifAbsent: [ nil ]} ] ]
]
