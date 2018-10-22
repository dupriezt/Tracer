"
# Instance variables:
metalinks
	LinkedList of instances of Metalink
	Metalinks installed by this Tracer instance
tracerui
	instance of TracerUI
	The instance of TracerUI this instance of Tracer is linked to, if there is one.
recordTrace
	LinkedList of TracerRecord
	Records recorded by this instance of Tracer
instrumentedMethods
	LinkedList of CompiledMethod
	List of the CompiledMethod that were instrumented by this instance of Tracer
"
Class {
	#name : #Tracer,
	#superclass : #Object,
	#instVars : [
		'metalinks',
		'tracerui',
		'recordTrace',
		'instrumentedMethods'
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

{ #category : #'as yet unclassified' }
Tracer >> clearRecordTrace [
	self recordTrace: nil
]

{ #category : #'public access' }
Tracer >> eval: sourceCode [
	^ self class evaluate: sourceCode
]

{ #category : #'as yet unclassified' }
Tracer >> instrumentMessageNode: aRBMessageNode [
	|metalink|
	metalink := MetaLink new
		metaObject: self;
		selector: #instrumentMethodAboutToBeCalled:;
		arguments: #(receiver selector);
		control: #before.
	metalink options add: #argsAsArray.
	"metalink optionArgsAsArray: true."
	aRBMessageNode link: metalink.
	self metalinks add: metalink.
]

{ #category : #'as yet unclassified' }
Tracer >> instrumentMethod: aCompiledMethod [
	"Does not instrument a method that this instance of Tracer already instrumented"
	(self isMethodInstrumented: aCompiledMethod) ifTrue: [^false].
	aCompiledMethod ast acceptVisitor: (TracerAstInstrumentorVisitor newFromTracer: self).
	self instrumentedMethods add: aCompiledMethod.	
]

{ #category : #'as yet unclassified' }
Tracer >> instrumentMethodAboutToBeCalled: reifiedArguments [
	| receiver selector receiverClass receiverClassVar methodAboutToBeCalled |
	receiver := reifiedArguments at: 1.
	selector := reifiedArguments at: 2.
	receiverClass := receiver class.
	receiverClassVar := receiverClass.
	"Looking for the method receiverClass>>selector"
	[receiverClassVar methodDict includesKey: selector] whileFalse: [ 
		(receiverClassVar isNil) ifTrue: [self error: 'Cannot find method ',selector asString, ' in class ', receiverClass name, ' or its superclasses'].
		receiverClassVar := receiverClassVar superclass.
	].
	"Method found. Instrumenting it if it is not already."
	methodAboutToBeCalled := receiverClassVar methodDict at: selector.
	self instrumentMethod: methodAboutToBeCalled.
	
	
]

{ #category : #'as yet unclassified' }
Tracer >> instrumentMethodAst: anAst [
	anAst acceptVisitor: (TracerAstInstrumentorVisitor newFromTracer: self).
]

{ #category : #'as yet unclassified' }
Tracer >> instrumentMethodNode: aRBMethodNode [
	|metalink|
	metalink := MetaLink new
		metaObject: self;
		selector: #makeRecord:;
		arguments: #(context).
	metalink options add: #argsAsArray.
	"metalink optionArgsAsArray: true."
	self halt.
	aRBMethodNode link: metalink.
	self metalinks add: metalink.
]

{ #category : #accessing }
Tracer >> instrumentedMethods [
	instrumentedMethods ifNil: [ instrumentedMethods := LinkedList new].
	^ instrumentedMethods
]

{ #category : #accessing }
Tracer >> instrumentedMethods: anObject [
	instrumentedMethods := anObject
]

{ #category : #accessing }
Tracer >> isMethodInstrumented: aCompiledMethod [
	^ self instrumentedMethods contains: [:compMeth | compMeth == aCompiledMethod].
]

{ #category : #'as yet unclassified' }
Tracer >> linkToUI: aTracerUI [
	self tracerui: aTracerUI
]

{ #category : #'as yet unclassified' }
Tracer >> makeRecord: reifications [
	| context |
	context := reifications at: 1.
	self recordTrace add: (TracerRecord newFromContext: context). 
	self tracerui ifNotNil: [ self tracerui updateRecordList  ].
]

{ #category : #accessing }
Tracer >> metalinks [
	metalinks ifNil: [ metalinks := LinkedList new ].
	^ metalinks
]

{ #category : #accessing }
Tracer >> metalinks: anObject [
	metalinks := anObject
]

{ #category : #accessing }
Tracer >> recordTrace [
	recordTrace ifNil: [ recordTrace := LinkedList new].
	^ recordTrace
]

{ #category : #accessing }
Tracer >> recordTrace: anObject [
	recordTrace := anObject
]

{ #category : #'as yet unclassified' }
Tracer >> traceExecutionOf: aString [
	|class compiledMethodSelector|
	self clearRecordTrace.
	class := Object newAnonymousSubclass.
	compiledMethodSelector := class compile: 'tracerDoIt ', (Character lf asString), (Character tab asString), aString.
	self instrumentMethod: (class methodDict at: compiledMethodSelector).
	class new perform: compiledMethodSelector.
	self halt.
	self uninstrumentInstrumentedMethods.
]

{ #category : #accessing }
Tracer >> tracerui [
	^ tracerui
]

{ #category : #accessing }
Tracer >> tracerui: anObject [
	tracerui := anObject
]

{ #category : #removing }
Tracer >> uninstrumentInstrumentedMethods [
	self metalinks do: [ :metalink | metalink uninstall ].
	self metalinks: nil.
	self instrumentedMethods: nil.
]
