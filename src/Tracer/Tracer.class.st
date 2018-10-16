Class {
	#name : #Tracer,
	#superclass : #Object,
	#instVars : [
		'tracei',
		'metalinks',
		'tracerui'
	],
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

{ #category : #'public access' }
Tracer >> eval: sourceCode [
	^ self class evaluate: sourceCode
]

{ #category : #'as yet unclassified' }
Tracer >> instrumentMethod: aCompiledMethod [
	self instrumentMethodAst: aCompiledMethod ast
]

{ #category : #'as yet unclassified' }
Tracer >> instrumentMethodAst: anAst [
	| metalink |
	metalink := MetaLink new
		metaObject: self;
		selector: #makeRecord:;
		arguments: #(receiver).
	metalink options add: #argsAsArray.
	"metalink optionArgsAsArray: true."
	anAst link: metalink.
	self metalinks add: metalink.
]

{ #category : #'as yet unclassified' }
Tracer >> instrumentMethodNamed: aSymbol ofObject: anObject [
	| class |
	class := anObject class.
	class methodDict at: aSymbol ifPresent: [ :compiledMethod |
		self instrumentMethod: compiledMethod
	] ifAbsent: [ self error: 'Method not found' ].
	self halt.
]

{ #category : #'as yet unclassified' }
Tracer >> linkToUI: aTracerUI [
	self tracerui: aTracerUI
]

{ #category : #'as yet unclassified' }
Tracer >> makeRecord: reifications [
	reifications inspect.
]

{ #category : #accessing }
Tracer >> metalinks [
	metalinks ifNil: [ metalinks := LinkedList new ].
	^ metalinks
]

{ #category : #removing }
Tracer >> removeMetalinks [
	self metalinks do: [ :metalink | metalink uninstall ]
]

{ #category : #accessing }
Tracer >> tracei [
	tracei ifNil: [ tracei := LinkedList new ].
	^ tracei
]

{ #category : #accessing }
Tracer >> tracei: anObject [
	tracei := anObject
]

{ #category : #accessing }
Tracer >> tracerui [
	^ tracerui
]

{ #category : #accessing }
Tracer >> tracerui: anObject [
	tracerui := anObject
]
