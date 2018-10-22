Class {
	#name : #TracerUI,
	#superclass : #ComposablePresenter,
	#instVars : [
		'recordList',
		'sourceCodeBox',
		'executeButton',
		'tracer'
	],
	#category : #Tracer
}

{ #category : #specs }
TracerUI class >> defaultSpec [

	^ SpecLayout composed
		newRow: [ :row | row add: #sourceCodeBox; add: #executeButton ]
		origin: 0 @ 0 corner: 1 @ 0.7;
		newRow: [ :row | row add: #recordList ]
		origin: 0 @ 0.7 corner: 1 @ 7.
]

{ #category : #'instance creation' }
TracerUI class >> open [
	<script>
	self new openWithSpec
]

{ #category : #accessing }
TracerUI >> executeButton [
	^ executeButton
]

{ #category : #accessing }
TracerUI >> executeButton: anObject [
	executeButton := anObject
]

{ #category : #initialization }
TracerUI >> extent [
	^ 400@100
]

{ #category : #initialization }
TracerUI >> initializeWidgets [
	
	tracer := Tracer new. "Not a widget"
	tracer linkToUI: self.
	
	recordList := ListPresenter new.
	recordList items: tracer recordTrace.
	sourceCodeBox := TextPresenter new.
	executeButton := self newButton.
	
	sourceCodeBox aboutToStyle: true.
	sourceCodeBox beForCode.
	sourceCodeBox autoAccept: true.
	sourceCodeBox acceptBlock: [ :txt | ].
	executeButton
		icon: (self iconNamed: #glamorousGo);
		action: [
			self tracer traceExecutionOf: (self sourceCodeBox getText asString)
		].
]

{ #category : #accessing }
TracerUI >> recordList [
	^ recordList
]

{ #category : #accessing }
TracerUI >> recordList: anObject [
	recordList := anObject
]

{ #category : #accessing }
TracerUI >> sourceCodeBox [
	^ sourceCodeBox
]

{ #category : #accessing }
TracerUI >> sourceCodeBox: anObject [
	sourceCodeBox := anObject
]

{ #category : #initialization }
TracerUI >> title [
	^ 'Tracer'.
]

{ #category : #accessing }
TracerUI >> tracer [
	^ tracer
]

{ #category : #accessing }
TracerUI >> tracer: anObject [
	tracer := anObject
]

{ #category : #'as yet unclassified' }
TracerUI >> updateRecordList [
	self recordList items: (self tracer recordTrace collect: [:tracerRecord | tracerRecord method name])
]
