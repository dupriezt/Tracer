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

{ #category : #'as yet unclassified' }
TracerTestAssistant >> testMethod1 [
	1+1.
	self testMethod2.
	^ 2.
]

{ #category : #'as yet unclassified' }
TracerTestAssistant >> testMethod2 [
	2+2.
	TracerTestAssistantBis new testMethod1: self.
]

{ #category : #'as yet unclassified' }
TracerTestAssistant >> testMethod3 [
	3+3.
	^6
]

{ #category : #'as yet unclassified' }
TracerTestAssistant >> testMethod4 [
	1 to: 4 do: [ self testMethod5 ].
]

{ #category : #'as yet unclassified' }
TracerTestAssistant >> testMethod5 [
	^ 42
]
