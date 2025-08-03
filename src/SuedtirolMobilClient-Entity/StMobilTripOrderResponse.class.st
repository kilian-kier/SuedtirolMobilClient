Class {
	#name : #StMobilTripOrderResponse,
	#superclass : #StMobilAbstractEntity,
	#category : #'SuedtirolMobilClient-Entity'
}

{ #category : #accessing }
StMobilTripOrderResponse >> orderId [
	^ rawData
]

{ #category : #private }
StMobilTripOrderResponse >> setRawData: aString client: aStMobilClient [
	rawData := aString.
	client := aStMobilClient
]
