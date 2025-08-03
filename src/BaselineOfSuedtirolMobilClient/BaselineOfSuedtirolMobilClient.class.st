Class {
	#name : #BaselineOfSuedtirolMobilClient,
	#superclass : #BaselineOf,
	#category : #BaselineOfSuedtirolMobilClient
}

{ #category : #loading }
BaselineOfSuedtirolMobilClient class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'SuedtirolMobilClient' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfSuedtirolMobilClient >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'SuedtirolMobilClient'
		]
]
