Class {
	#name : #TracerTestAssistantBis,
	#superclass : #Object,
	#category : #'Tracer-Tests'
}

{ #category : #tests }
TracerTestAssistantBis >> testMethod1: caller [
	self testMethod2: caller.
]

{ #category : #tests }
TracerTestAssistantBis >> testMethod2: caller [
	caller testMethod3.
]
