Class {
	#name : #TracerTestAssistant,
	#superclass : #Object,
	#category : #'Tracer-Tests'
}

{ #category : #'as yet unclassified' }
TracerTestAssistant >> markedMethod1 [
	1+1.
	Tracer mark: thisContext.
	2+2.
]

{ #category : #'as yet unclassified' }
TracerTestAssistant >> markedMethod2 [
	3+3.
	Tracer mark: thisContext.
	4+4.
]
