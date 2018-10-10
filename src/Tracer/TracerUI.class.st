Class {
	#name : #TracerUI,
	#superclass : #ComposablePresenter,
	#instVars : [
		'recordList',
		'sourceCodeBox',
		'executeButton'
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
	
	recordList := ListPresenter new.
	sourceCodeBox := TextPresenter new.
	executeButton := self newButton.
	
	sourceCodeBox aboutToStyle: true.
	sourceCodeBox beForCode.
	sourceCodeBox autoAccept: true.
	sourceCodeBox acceptBlock: [ :txt | ].
	executeButton
		icon: (self iconNamed: #glamorousGo);
		action: [ Tracer eval: (self sourceCodeBox getText)].
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
