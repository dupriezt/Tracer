Class {
	#name : #TracerRecord,
	#superclass : #Object,
	#instVars : [
		'method',
		'receiver',
		'sender'
	],
	#category : #Tracer
}

{ #category : #'instance creation' }
TracerRecord class >> newFromContext: aContext [
	| newToolRecord |
	newToolRecord := self new.
	newToolRecord method: aContext method.
	newToolRecord receiver: aContext receiver.
	newToolRecord sender: aContext sender.
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
TracerRecord >> sender [
	^ sender
]

{ #category : #accessing }
TracerRecord >> sender: anObject [
	sender := anObject
]
