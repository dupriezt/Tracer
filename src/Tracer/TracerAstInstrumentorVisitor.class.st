Class {
	#name : #TracerAstInstrumentorVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'tracer'
	],
	#category : #Tracer
}

{ #category : #'instance creation' }
TracerAstInstrumentorVisitor class >> newFromTracer: aTracer [
	^ self new
		tracer: aTracer;
		yourself.
]

{ #category : #accessing }
TracerAstInstrumentorVisitor >> tracer [
	^ tracer
]

{ #category : #accessing }
TracerAstInstrumentorVisitor >> tracer: anObject [
	tracer := anObject
]

{ #category : #visiting }
TracerAstInstrumentorVisitor >> visitMessageNode: aMessageNode [
	self tracer instrumentMessageNode: aMessageNode.
	super visitMessageNode: aMessageNode.

]

{ #category : #visiting }
TracerAstInstrumentorVisitor >> visitMethodNode: aMethodNode [
	self tracer instrumentMethodNode: aMethodNode.
	super visitMethodNode: aMethodNode.

]
