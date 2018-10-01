Class {
	#name : #TracerRecord,
	#superclass : #Object,
	#instVars : [
		'method'
	],
	#category : #Tracer
}

{ #category : #'instance creation' }
TracerRecord class >> newFromContext: aContext [
	| newToolRecord |
	newToolRecord := self new.
	newToolRecord method: aContext method.
	^ newToolRecord 
]

{ #category : #accessing }
TracerRecord >> method [
	^ method
]

{ #category : #accessing }
TracerRecord >> method: anObject [
	method := anObject
]
