Class {
	#name : #Tracer,
	#superclass : #Object,
	#classVars : [
		'recordingOn',
		'trace'
	],
	#category : #Tracer
}

{ #category : #'as yet unclassified' }
Tracer class >> cleanTrace [
	trace := LinkedList new.
]

{ #category : #private }
Tracer class >> getTrace [
	^ trace
]

{ #category : #private }
Tracer class >> mark: aContext [
	self recordingOn ifTrue:[
		 trace add: (TracerRecord newFromContext: aContext).
	].
]

{ #category : #'as yet unclassified' }
Tracer class >> recordingOn [
	^ recordingOn
]

{ #category : #'as yet unclassified' }
Tracer class >> recordingOn: aBoolean [
	recordingOn := aBoolean
]
