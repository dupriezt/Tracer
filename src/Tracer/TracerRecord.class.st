Class {
	#name : #TracerRecord,
	#superclass : #Object,
	#instVars : [
		'method',
		'receiver',
		'senderMethod'
	],
	#category : #Tracer
}

{ #category : #'instance creation' }
TracerRecord class >> newFromContext: aContext [
	| newToolRecord |
	newToolRecord := self new.
	newToolRecord method: aContext method.
	newToolRecord receiver: aContext receiver.
	"Following keeps giving a context from the metalink machinery. Should keep calling sender until the sender is not from Reflectivity"
	"newToolRecord senderMethod: aContext sender method."
	newToolRecord senderMethod: aContext home sender method.
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

{ #category : #accessing }
TracerRecord >> receiver [
	^ receiver
]

{ #category : #accessing }
TracerRecord >> receiver: anObject [
	receiver := anObject
]

{ #category : #accessing }
TracerRecord >> senderMethod [
	^ senderMethod
]

{ #category : #accessing }
TracerRecord >> senderMethod: anObject [
	senderMethod := anObject
]
