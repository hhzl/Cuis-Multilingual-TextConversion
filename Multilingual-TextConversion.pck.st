'From Cuis 4.1 of 12 December 2012 [latest update: #1576] on 6 February 2013 at 7:16:32 am'!
'Description Please enter a description for this package '!
!classDefinition: #MultiByteFileStream category: #'Multilingual-TextConversion'!
StandardFileStream subclass: #MultiByteFileStream
	instanceVariableNames: 'converter lineEndConvention wantsLineEndConversion'
	classVariableNames: 'Cr CrLf Lf LineEndDefault LineEndStrings LookAheadCount'
	poolDictionaries: ''
	category: 'Multilingual-TextConversion'!
!classDefinition: 'MultiByteFileStream class' category: #'Multilingual-TextConversion'!
MultiByteFileStream class
	instanceVariableNames: ''!

!classDefinition: #TextConverter category: #'Multilingual-TextConversion'!
Object subclass: #TextConverter
	instanceVariableNames: 'latin1Map latin1Encodings'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Multilingual-TextConversion'!
!classDefinition: 'TextConverter class' category: #'Multilingual-TextConversion'!
TextConverter class
	instanceVariableNames: ''!

!classDefinition: #UTF8TextConverter category: #'Multilingual-TextConversion'!
TextConverter subclass: #UTF8TextConverter
	instanceVariableNames: ''
	classVariableNames: 'StrictUtf8Conversions'
	poolDictionaries: ''
	category: 'Multilingual-TextConversion'!
!classDefinition: 'UTF8TextConverter class' category: #'Multilingual-TextConversion'!
UTF8TextConverter class
	instanceVariableNames: ''!


!MultiByteFileStream commentStamp: 'hjh 2/6/2013 07:14' prior: 0!
The central class to access the external file.  The interface of this object is similar to good old StandardFileStream, but internally it asks the converter, which is a sub-instance of TextConverter, and do the text conversion.
It also combined the good old CrLfFileStream.  CrLfFileStream class>>new now returns an instance of MultiByteFileStream.
There are several pitfalls

  * You always have to be careful about the binary/text distinction.  In #text mode, it usually interprets the bytes.
  * A few file pointer operations treat the file as uninterpreted byte no matter what.  This means that if you use 'fileStream skip: -1', 'fileStream position: x', etc. in #text mode, the file position can be in the middle of multi byte character.  If you want to implement some function similar to #peek for example, call the saveStateOf: and restoreStateOf: methods to be able to get back to the original state.

  * #lineEndConvention: and #wantsLineEndConversion: (and #binary) can cause some puzzling situation because the inst var lineEndConvention and wantsLineEndConversion are mutated.  If you have any suggestions to clean up the protocol, please let me know.


Class copied from Squeak 4.4. as is. Needs testing.!

!TextConverter commentStamp: 'hjh 2/6/2013 07:15' prior: 0!
The abstract class for all different type of text converters.  

     nextFromStream: 
        and 
     nextPut:toStream: 

    are the public accessible methods.  

If you are going to make a subclass for a stateful text conversion, you should override restoreStateOf:with: and saveStateOf: along the line of CompoundTextConverter.


From Squeak 4.4

Only the class definition so far. More methods need to be copied as the need arises.

!

!UTF8TextConverter commentStamp: 'hjh 2/6/2013 07:12' prior: 0!
Text converter for UTF-8.  Since the BOM is used to distinguish the MacRoman code and UTF-8 code, BOM is written for UTF-8 by #writeBOMOn: which is called by client.


Class copied from Squeak 4.4. as is. Needs testing and removing of unnecessary methods.!

!MultiByteFileStream methodsFor: 'remnant' stamp: 'yo 8/28/2002 11:06'!
accepts: aSymbol 	^ converter accepts: aSymbol.! !

!MultiByteFileStream methodsFor: 'accessing' stamp: 'yo 2/21/2004 02:57'!
ascii	super ascii.	self detectLineEndConvention.! !

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 3/22/2010 07:59'!
back	^converter backFromStream: self! !

!MultiByteFileStream methodsFor: 'crlf private' stamp: 'ul 1/20/2011 01:51'!
bareNext	self deprecated: 'Don''t use this method anymore.'.	^converter nextFromStream: self.! !

!MultiByteFileStream methodsFor: 'private basic' stamp: 'ul 3/22/2010 07:50'!
basicBack	self position = 0 ifTrue: [ self errorCantGoBack ].	self skip: -1.	^self basicPeek! !

!MultiByteFileStream methodsFor: 'private basic' stamp: 'ul 1/28/2010 02:29'!
basicNext: anInteger	^self basicNextInto: (self collectionSpecies new: anInteger)! !

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:07'!
basicNext: n into: aString	^ super next: n into: aString.! !

!MultiByteFileStream methodsFor: 'private basic' stamp: 'ul 1/31/2011 02:05'!
basicNext: anInteger putAll: aCollection startingAt: startIndex	^super next: anInteger putAll: aCollection startingAt: startIndex! !

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:07'!
basicNextInto: aString	^ super nextInto: aString.! !

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:07'!
basicNextPut: char	^ super nextPut: char.! !

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:07'!
basicNextPutAll: aString	^ super nextPutAll: aString.! !

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:07'!
basicPeek	^ super peek! !

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:08'!
basicPosition	^ super position.! !

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:08'!
basicPosition: pos	^ super position: pos.! !

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:08'!
basicReadInto: byteArray startingAt: startIndex count: count	^ super readInto: byteArray startingAt: startIndex count: count.! !

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:08'!
basicSetToEnd	^ super setToEnd.! !

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:08'!
basicSkip: n	^ super skip: n.! !

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:08'!
basicUpTo: delim	^ super upTo: delim.! !

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:09'!
basicVerbatim: aString	^ super verbatim: aString.! !

!MultiByteFileStream methodsFor: 'accessing' stamp: 'nice 5/10/2009 00:14'!
binary	super binary.	self lineEndConvention: nil! !

!MultiByteFileStream methodsFor: 'crlf private' stamp: 'ul 1/30/2011 04:35'!
convertStringFromCr: aString 	| inStream outStream |		self deprecated: 'This method is obsolete and private, don''t use it!!'.	lineEndConvention ifNil: [^ aString].	lineEndConvention == #cr ifTrue: [^ aString].	lineEndConvention == #lf ifTrue: [^ aString copy replaceAll: Cr with: Lf].	"lineEndConvention == #crlf"	inStream := ReadStream on: aString.	outStream := WriteStream on: (String new: aString size).	[inStream atEnd]		whileFalse: 			[outStream nextPutAll: (inStream upTo: Cr).			(inStream atEnd not or: [aString last = Cr])				ifTrue: [outStream nextPutAll: CrLf]].	^ outStream contents! !

!MultiByteFileStream methodsFor: 'crlf private' stamp: 'ul 1/30/2011 04:35'!
convertStringToCr: aString 	| inStream outStream |		self deprecated: 'This method is obsolete and private, don''t use it!!'.	lineEndConvention ifNil: [^ aString].	lineEndConvention == #cr ifTrue: [^ aString].	lineEndConvention == #lf ifTrue: [^ aString copy replaceAll: Lf with: Cr].	"lineEndConvention == #crlf"	inStream := ReadStream on: aString.	outStream := WriteStream on: (String new: aString size).	[inStream atEnd]		whileFalse: 			[outStream nextPutAll: (inStream upTo: Cr).			(inStream atEnd not or: [aString last = Cr])				ifTrue: 					[outStream nextPut: Cr.					inStream peek = Lf ifTrue: [inStream next]]].	^ outStream contents! !

!MultiByteFileStream methodsFor: 'accessing' stamp: 'ul 1/20/2011 01:42'!
converter	^converter ifNil: [		self initializeConverter.		converter ]! !

!MultiByteFileStream methodsFor: 'accessing' stamp: 'nice 5/10/2009 00:18'!
converter: aConverter	converter := aConverter.	self installLineEndConventionInConverter! !

!MultiByteFileStream methodsFor: 'crlf private' stamp: 'ul 1/30/2011 04:34'!
detectLineEndConvention	"Detect the line end convention used in this stream. The result may be either #cr, #lf or #crlf."	| char numRead state |	self isBinary ifTrue: [^ self error: 'Line end conventions are not used on binary streams'].	wantsLineEndConversion ifFalse: [self lineEndConvention: nil.					^lineEndConvention].	self closed ifTrue: [self lineEndConvention: LineEndDefault.					^lineEndConvention].	"Default if nothing else found"	numRead := 0.	state := converter saveStateOf: self.	lineEndConvention := nil.	[super atEnd not and: [numRead < LookAheadCount]]		whileTrue: 			[char := self next.			char = Lf				ifTrue: 					[converter restoreStateOf: self with: state.					self lineEndConvention: #lf.					^lineEndConvention].			char = Cr				ifTrue: 					[self peek = Lf						ifTrue: [self lineEndConvention: #crlf]						ifFalse: [self lineEndConvention: #cr].					converter restoreStateOf: self with: state.					^ lineEndConvention].			numRead := numRead + 1].	converter restoreStateOf: self with: state.	self lineEndConvention: LineEndDefault.	^ lineEndConvention! !

!MultiByteFileStream methodsFor: 'crlf private' stamp: 'ul 1/30/2011 04:35'!
doConversion	^wantsLineEndConversion and: [ lineEndConvention notNil ]! !

!MultiByteFileStream methodsFor: 'fileIn/Out' stamp: 'yo 8/17/2004 10:03'!
fileIn	self setConverterForCode.	super fileIn.! !

!MultiByteFileStream methodsFor: 'accessing' stamp: 'yo 8/6/2003 11:56'!
fileInEncodingName: aString	self converter: (TextConverter newForEncoding: aString).	super fileIn.! !

!MultiByteFileStream methodsFor: 'fileIn/Out' stamp: 'ar 7/29/2005 22:33'!
fileInObjectAndCodeForProject	"This file may contain:1) a fileIn of code  2) just an object in SmartReferenceStream format 3) both code and an object.	File it in and return the object.  Note that self must be a FileStream or RWBinaryOrTextStream.  Maybe ReadWriteStream incorporate RWBinaryOrTextStream?"	| refStream object |	self text.	self peek asciiValue = 4		ifTrue: [  "pure object file"			self binary.			refStream := SmartRefStream on: self.			object := refStream nextAndClose]		ifFalse: [  "objects mixed with a fileIn"			self fileInProject.  "reads code and objects, then closes the file"			self binary.			object := SmartRefStream scannedObject].	"set by side effect of one of the chunks"	SmartRefStream scannedObject: nil.  "clear scannedObject"	^ object! !

!MultiByteFileStream methodsFor: 'fileIn/Out' stamp: 'ar 7/29/2005 22:33'!
fileInProject	self setConverterForCodeForProject.	super fileIn.! !

!MultiByteFileStream methodsFor: 'fileIn/Out' stamp: 'tak 1/12/2005 14:48'!
fileOutClass: extraClass andObject: theObject 	self binary.	UTF8TextConverter writeBOMOn: self.	self text.	^ super fileOutClass: extraClass andObject: theObject! !

!MultiByteFileStream methodsFor: 'remnant' stamp: 'yo 8/28/2002 11:09'!
filterFor: aFileStream	| rw |	name := aFileStream name.	rw := aFileStream isReadOnly not.	aFileStream close.	self open: name forWrite: rw.	^self.! !

!MultiByteFileStream methodsFor: 'initialize-release' stamp: 'ul 1/30/2011 04:28'!
initialize	super initialize.	wantsLineEndConversion := false.	self initializeConverter! !

!MultiByteFileStream methodsFor: 'initialize-release' stamp: 'ul 1/4/2011 07:53'!
initializeConverter	self converter: TextConverter defaultSystemConverter! !

!MultiByteFileStream methodsFor: 'private' stamp: 'ul 1/30/2011 04:36'!
installLineEndConventionInConverter	converter ifNotNil: [		converter installLineEndConvention: (			(wantsLineEndConversion and: [ lineEndConvention notNil ]) "#doConversion is inlined here"				ifTrue: [ LineEndStrings at: lineEndConvention ]				ifFalse: [ nil ]) ]! !

!MultiByteFileStream methodsFor: 'accessing' stamp: 'nk 9/5/2004 12:57'!
lineEndConvention	^lineEndConvention! !

!MultiByteFileStream methodsFor: 'accessing' stamp: 'nice 11/28/2009 13:06'!
lineEndConvention: aSymbol	(lineEndConvention := aSymbol) ifNotNil: [wantsLineEndConversion := true].	self installLineEndConventionInConverter! !

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 1/30/2011 04:34'!
next	| char |	char := converter nextFromStream: self.	"#doConversion is inlined here"	(wantsLineEndConversion and: [ lineEndConvention notNil ]) ifTrue: [		char == Cr ifTrue: [			| state |			state := converter saveStateOf: self.			(converter nextFromStream: self) ifNotNil: [ :secondChar |				secondChar == Lf ifFalse: [					converter restoreStateOf: self with: state ] ].			^Cr ].		char == Lf ifTrue: [			^Cr ] ].	^char.! !

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 1/30/2011 04:31'!
next: anInteger 	| multiString |	self isBinary ifTrue: [^ super next: anInteger].	multiString := String new: anInteger.	1 to: anInteger do: [:index |		| character |		(character := self next)			ifNotNil: [ multiString at: index put: character ]			ifNil: [				multiString := multiString copyFrom: 1 to: index - 1.				(wantsLineEndConversion and: [ lineEndConvention notNil ]) "#doConversion is inlined here"					ifFalse: [ ^multiString ].				^self next: anInteger innerFor: multiString ] ].	(wantsLineEndConversion and: [ lineEndConvention notNil ]) "#doConversion is inlined here"		 ifFalse: [ ^multiString ].	multiString := self next: anInteger innerFor: multiString.	(multiString size = anInteger or: [self atEnd]) ifTrue: [ ^ multiString].	^ multiString, (self next: anInteger - multiString size).! !

!MultiByteFileStream methodsFor: 'crlf private' stamp: 'ul 12/27/2010 04:43'!
next: n innerFor: aString	aString size = 0 ifTrue: [^ aString].	"if we just read a CR, and the next character is an LF, then skip the LF"	aString last == Cr ifTrue: [		| state |		state := converter saveStateOf: self.		(converter nextFromStream: self) ifNotNil: [ :peekChar |			peekChar == Lf ifFalse: [				converter restoreStateOf: self with: state ] ] ].	^aString withSqueakLineEndings! !

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 1/31/2011 02:08'!
next: anInteger putAll: aCollection startingAt: startIndex	(self isBinary or: [ aCollection class == ByteArray ]) ifTrue: [		^super next: anInteger putAll: aCollection startingAt: startIndex ].	^converter next: anInteger putAll: aCollection startingAt: startIndex toStream: self! !

!MultiByteFileStream methodsFor: 'fileIn/Out' stamp: 'ul 2/5/2010 23:59'!
nextChunk	"Answer the contents of the receiver, up to the next terminator character. Doubled terminators indicate an embedded terminator character."	^converter nextChunkFromStream: self! !

!MultiByteFileStream methodsFor: 'fileIn/Out' stamp: 'ul 2/7/2010 04:41'!
nextChunkText	"Deliver the next chunk as a Text.  Decode the following ]style[ chunk if present.  Position at start of next real chunk."		^converter nextChunkTextFromStream: self! !

!MultiByteFileStream methodsFor: 'public' stamp: 'yo 2/21/2004 03:26'!
nextDelimited: terminator	| out ch save |	out := WriteStream on: (String new: 1000).	self atEnd ifTrue: [^ ''].	save := converter saveStateOf: self.	self next = terminator ifFalse: [		"absorb initial terminator"		converter restoreStateOf: self with: save.	].	[(ch := self next) == nil] whileFalse: [		(ch = terminator) ifTrue: [			self peek = terminator ifTrue: [				self next.  "skip doubled terminator"			] ifFalse: [				^ out contents  "terminator is not doubled; we're done!!"			].		].		out nextPut: ch.	].	^ out contents.! !

!MultiByteFileStream methodsFor: 'public' stamp: 'yo 8/28/2002 11:13'!
nextMatchAll: aColl    | save |    save := converter saveStateOf: self.    aColl do: [:each |       (self next) = each ifFalse: [            converter restoreStateOf: self with: save.            ^ false.		].	].    ^ true.! !

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 5/17/2011 17:30'!
nextPut: aCharacter	aCharacter isInteger ifTrue: [ ^super nextPut: aCharacter ].	^converter nextPut: aCharacter toStream: self! !

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 1/31/2011 02:07'!
nextPutAll: aCollection	(self isBinary or: [aCollection class == ByteArray]) ifTrue: [		^ super nextPutAll: aCollection.	].	^converter nextPutAll: aCollection toStream: self! !

!MultiByteFileStream methodsFor: 'open/close' stamp: 'HenrikSperreJohansen 11/20/2009 15:13'!
open: fileName forWrite: writeMode 	| result |	result := super open: fileName forWrite: writeMode.	result ifNotNil: [			converter ifNil: [self converter: UTF8TextConverter new].			lineEndConvention ifNil: [ self detectLineEndConvention ]	].	^result! !

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 3/15/2011 13:32'!
peek	"Answer what would be returned if the message next were sent to the receiver. If the receiver is at the end, answer nil.  "	| next state |	state := converter saveStateOf: self.	next := self next.	converter restoreStateOf: self with: state.	^next! !

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 5/26/2010 04:03'!
peekFor: item 	| next state |	"self atEnd ifTrue: [^ false]. -- SFStream will give nil"	state := converter saveStateOf: self.	(next := self next) ifNil: [^ false].	item = next ifTrue: [^ true].	converter restoreStateOf: self with: state.	^ false.! !

!MultiByteFileStream methodsFor: 'private' stamp: 'ar 4/10/2010 20:48'!
requestDropStream: dropIndex	"Needs to install proper converter"	| result |	result := super requestDropStream: dropIndex.	result ifNotNil: [		converter ifNil: [self converter: UTF8TextConverter new].		lineEndConvention ifNil: [ self detectLineEndConvention ]	].	^result! !

!MultiByteFileStream methodsFor: 'open/close' stamp: 'nice 5/10/2009 00:18'!
reset	super reset.	converter ifNil: [		self converter: UTF8TextConverter new.	].! !

!MultiByteFileStream methodsFor: 'private' stamp: 'ul 1/20/2011 01:55'!
setConverterForCode	| currentPosition |	(SourceFiles at: 2)		ifNotNil: [self fullName = (SourceFiles at: 2) fullName ifTrue: [^ self]].	currentPosition := self position.	self position: 0.	self binary.	((self next: 3) = #[ 16rEF 16rBB 16rBF ]) ifTrue: [		self converter: UTF8TextConverter new	] ifFalse: [		self converter: MacRomanTextConverter new.	].	self position: currentPosition.	self text.! !

!MultiByteFileStream methodsFor: 'private' stamp: 'ar 7/29/2005 22:33'!
setConverterForCodeForProject	self converter: UTF8TextConverter new.! !

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 3/27/2010 00:04'!
skipSeparators	converter skipSeparatorsFrom: self! !

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 3/27/2010 16:19'!
skipSeparatorsAndPeekNext	"A special function to make nextChunk fast. Same as #skipSeparators, but returns the next character after the separators if such exists."		^converter skipSeparatorsAndPeekNextFrom: self! !

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 12/4/2009 19:08'!
upTo: delimiter	^self collectionSpecies new: 1000 streamContents: [ :stream |		| ch |		[ (ch := self next) == nil or: [ ch = delimiter ] ] 			whileFalse: [ stream nextPut: ch ] ]! !

!MultiByteFileStream methodsFor: 'public' stamp: 'nice 12/7/2009 08:26'!
upToAnyOf: delimiters do: aBlock	^self collectionSpecies new: 1000 streamContents: [ :stream |		| ch |		[ (ch := self next) == nil or: [ (delimiters includes: ch) and: [aBlock value: ch. true] ] ] 			whileFalse: [ stream nextPut: ch ] ]! !

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 12/6/2009 04:18'!
upToEnd	^self collectionSpecies		new: self size - self position		streamContents: [ :stream |			| element |			[ (element := self next) == nil ] whileFalse: [				stream nextPut: element ] ]! !

!MultiByteFileStream methodsFor: 'crlf private' stamp: 'ul 1/30/2011 04:31'!
wantsLineEndConversion	^wantsLineEndConversion! !

!MultiByteFileStream methodsFor: 'remnant' stamp: 'ul 1/30/2011 04:35'!
wantsLineEndConversion: aBoolean		wantsLineEndConversion := aBoolean.	lineEndConvention ifNil: [ self detectLineEndConvention ]! !

!MultiByteFileStream class methodsFor: 'class initialization' stamp: 'yo 2/21/2004 02:45'!
defaultToCR	"MultiByteFileStream defaultToCR"	LineEndDefault := #cr.! !

!MultiByteFileStream class methodsFor: 'class initialization' stamp: 'yo 2/21/2004 02:45'!
defaultToCRLF	"MultiByteFileStream defaultToCRLF"	LineEndDefault := #crlf.! !

!MultiByteFileStream class methodsFor: 'class initialization' stamp: 'yo 2/21/2004 02:46'!
defaultToLF	"MultiByteFileStream defaultToLF"	LineEndDefault := #lf.! !

!MultiByteFileStream class methodsFor: 'class initialization' stamp: 'nice 11/27/2009 22:01'!
guessDefaultLineEndConvention	"Lets try to guess the line end convention from what we know about the	path name delimiter from FileDirectory."	FileDirectory pathNameDelimiter = $:		ifTrue: [^ self defaultToCR].	FileDirectory pathNameDelimiter = $/		ifTrue: [((SmalltalkImage current osVersion)					beginsWith: 'darwin')				ifTrue: [^ self defaultToCR]				ifFalse: [^ self defaultToLF]].	FileDirectory pathNameDelimiter = $\		ifTrue: [^ self defaultToCRLF].	"in case we don't know"	^ self defaultToCR! !

!MultiByteFileStream class methodsFor: 'class initialization' stamp: 'yo 2/21/2004 02:44'!
initialize	"MultiByteFileStream initialize"	Cr := Character cr.	Lf := Character lf.	CrLf := String with: Cr with: Lf.	LineEndStrings := Dictionary new.	LineEndStrings at: #cr put: (String with: Character cr).	LineEndStrings at: #lf put: (String with: Character lf).	LineEndStrings at: #crlf put: (String with: Character cr with: Character lf).	LookAheadCount := 2048.	Smalltalk addToStartUpList: self.	self startUp.! !

!MultiByteFileStream class methodsFor: 'accessing' stamp: 'cmm 10/10/2010 19:17'!
lineEndDefault	"Answer the default line-ending convention that will be used by default, which was determined at start-up by looking at platform atributes."	^ LineEndDefault! !

!MultiByteFileStream class methodsFor: 'as yet unclassified' stamp: 'ul 1/20/2011 02:18'!
newForStdio	"Use crlf as line end convention on windows, lf on all other platforms. Also make sure that the converter is initialized."		| lineEndConvention |	lineEndConvention := self lineEndDefault.	lineEndConvention == #crlf ifFalse: [		lineEndConvention := #lf ].	^self new		lineEndConvention: lineEndConvention;		initializeConverter;		yourself! !

!MultiByteFileStream class methodsFor: 'instance creation' stamp: 'yo 8/28/2002 11:43'!
newFrom: aFileStream	| rw n |	n := aFileStream name.	rw := aFileStream isReadOnly not.	aFileStream close.	^self new open: n forWrite: rw.! !

!MultiByteFileStream class methodsFor: 'class initialization' stamp: 'yo 2/21/2004 02:44'!
startUp	self guessDefaultLineEndConvention.! !

!UTF8TextConverter methodsFor: 'conversion' stamp: 'ul 3/22/2010 08:18'!
backFromStream: aStream	aStream position = 0 ifTrue: [ ^nil ].	aStream isBinary ifTrue: [ ^aStream basicBack ].	[ aStream position = 0 or: [ 		(aStream basicBack asciiValue bitXor: 128) >= 64 ] ] whileFalse.	^aStream peek! !

!UTF8TextConverter methodsFor: 'conversion' stamp: 'ul 3/17/2010 10:06'!
decodeString: aString	aString isByteString ifTrue: [ ^self class decodeByteString: aString ].	^super decodeString: aString! !

!UTF8TextConverter methodsFor: 'conversion' stamp: 'ul 3/17/2010 10:07'!
encodeString: aString	aString isByteString ifTrue: [ ^self class encodeByteString: aString ].	^super encodeString: aString! !

!UTF8TextConverter methodsFor: 'conversion' stamp: 'ar 9/1/2010 18:21'!
errorMalformedInput: aString	"Invalid UTF-8 input has been detected in the given string.	Raise an error if strict conversions are enabled, otherwise allow	the original string to be returned."		^self class errorMalformedInput: aString! !

!UTF8TextConverter methodsFor: 'friend' stamp: 'yo 11/8/2002 16:17'!
leadingChar	^ self shouldNotImplement! !

!UTF8TextConverter methodsFor: 'fileIn/Out' stamp: 'ul 3/27/2010 00:12'!
nextChunkFromStream: input	"Answer the contents of input, up to the next terminator character. Doubled terminators indicate an embedded terminator character."		self skipSeparatorsFrom: input.	^self 		parseLangTagFor: (			self class decodeByteString: (				String new: 1000 streamContents: [ :stream |					[						stream nextPutAll: (input basicUpTo: $!!).						input basicNext == $!! ]							whileTrue: [ 								stream nextPut: $!! ].					input atEnd ifFalse: [ input skip: -1 ] ]))		fromStream: input! !

!UTF8TextConverter methodsFor: 'fileIn/Out' stamp: 'ul 3/27/2010 00:11'!
nextChunkTextFromStream: input	"Deliver the next chunk as a Text.  Decode the following ]style[ chunk if present.  Position at start of next real chunk."		| chunk position runs |	chunk := self nextChunkFromStream: input.	position := input position.	((self skipSeparatorsAndPeekNextFrom: input) == $] and: [		(input basicNext: 7) = ']style[' ])			ifTrue: [				runs := RunArray scanFrom: (self nextChunkFromStream: input) readStream ]			ifFalse: [				input position: position.				runs := RunArray new: chunk size withAll: #() ].	^Text string: chunk runs: runs! !

!UTF8TextConverter methodsFor: 'conversion' stamp: 'ar 9/1/2010 18:21'!
nextFromStream: aStream	| char1 value1 char2 value2 unicode char3 value3 char4 value4 |	aStream isBinary ifTrue: [^ aStream basicNext].	char1 := aStream basicNext.	char1 ifNil:[^ nil].	value1 := char1 asciiValue.	value1 <= 127 ifTrue: [		"1-byte char"		^ char1	].	"at least 2-byte char"	char2 := aStream basicNext.	char2 ifNil:[^self errorMalformedInput: (String with: char1)].	value2 := char2 asciiValue.	(value1 bitAnd: 16rE0) = 192 ifTrue: [		^ Unicode value: ((value1 bitAnd: 31) bitShift: 6) + (value2 bitAnd: 63).	].	"at least 3-byte char"	char3 := aStream basicNext.	char3 ifNil:[^self errorMalformedInput: (String with: char1 with: char2)].	value3 := char3 asciiValue.	(value1 bitAnd: 16rF0) = 224 ifTrue: [		unicode := ((value1 bitAnd: 15) bitShift: 12) + ((value2 bitAnd: 63) bitShift: 6)				+ (value3 bitAnd: 63).	].	(value1 bitAnd: 16rF8) = 240 ifTrue: [		"4-byte char"		char4 := aStream basicNext.		char4 ifNil:[^self errorMalformedInput: (String with: char1 with: char2 with: char3)].		value4 := char4 asciiValue.		unicode := ((value1 bitAnd: 16r7) bitShift: 18) +					((value2 bitAnd: 63) bitShift: 12) + 					((value3 bitAnd: 63) bitShift: 6) +					(value4 bitAnd: 63).	].	unicode ifNil:[^self errorMalformedInput: (String with: char1 with: char2 with: char3)].	unicode > 16r10FFFD ifTrue: [		^self errorMalformedInput: (String with: char1 with: char2 with: char3).	].		unicode = 16rFEFF ifTrue: [^ self nextFromStream: aStream].	^ Unicode value: unicode.! !

!UTF8TextConverter methodsFor: 'conversion' stamp: 'ul 5/17/2011 17:25'!
nextPut: aCharacter toStream: aStream 		| nBytes mask shift ucs2code |	aStream isBinary ifTrue: [ ^aCharacter storeBinaryOn: aStream ].	ucs2code := aCharacter asUnicode ifNil: [ ^aCharacter ].	ucs2code < 256 ifTrue: [		(latin1Encodings at: ucs2code + 1)			ifNil: [ aStream basicNextPut: aCharacter ]			ifNotNil: [ :encodedString | aStream basicNextPutAll: encodedString ].		^aCharacter ].	nBytes := ucs2code highBit + 3 // 5.	mask := #[128 192 224 240 248 252 254 255] at: nBytes.	shift := nBytes - 1 * -6.	aStream basicNextPut: (Character value: (ucs2code bitShift: shift) + mask).	2 to: nBytes do: [ :i | 		shift := shift + 6.		aStream basicNextPut: (			Character value: ((ucs2code bitShift: shift) bitAnd: 63) + 128) ].	^aCharacter.! !

!UTF8TextConverter methodsFor: 'fileIn/Out' stamp: 'ul 3/27/2010 00:09'!
parseLangTagFor: aString fromStream: stream	| position |	position := stream position.	"Test for ]lang[ tag"	((self skipSeparatorsAndPeekNextFrom: stream) == $] and: [		(stream basicNext: 6) = ']lang[' ]) ifTrue: [			^stream				decodeString: aString				andRuns: (self nextChunkFromStream: stream) ].	"no tag"	stream position: position.	^aString! !

!UTF8TextConverter methodsFor: 'fileIn/Out' stamp: 'ul 3/27/2010 16:44'!
skipSeparatorsAndPeekNextFrom: aStream	"Same as #skipSeparators, but returns the next character after the separators if such exists."	| character |	[ 		((character := aStream basicNext) 			ifNil: [ ^aStream "backwards compatibility, should be nil" ])				isSeparator ] whileTrue.	aStream skip: -1.	^character	! !

!UTF8TextConverter methodsFor: 'fileIn/Out' stamp: 'ul 3/27/2010 00:04'!
skipSeparatorsFrom: aStream	[ (aStream basicNext ifNil: [ ^self ]) isSeparator ] whileTrue.	aStream skip: -1! !

!UTF8TextConverter class methodsFor: 'conversion' stamp: 'ar 9/1/2010 18:11'!
decodeByteString: aByteString	"Convert the given string from UTF-8 using the fast path if converting to Latin-1"	| outStream lastIndex nextIndex byte1 byte2 byte3 byte4 unicode |	lastIndex := 1.	(nextIndex := ByteString findFirstInString: aByteString inSet: latin1Map startingAt: lastIndex) = 0		ifTrue: [ ^aByteString ].	outStream := (String new: aByteString size) writeStream.	[		outStream next: nextIndex - lastIndex putAll: aByteString startingAt: lastIndex.		byte1 := aByteString byteAt: nextIndex.		(byte1 bitAnd: 16rE0) = 192 ifTrue: [ "two bytes"			byte2 := aByteString byteAt: (nextIndex := nextIndex + 1).			(byte2 bitAnd: 16rC0) = 16r80 ifFalse:[	^self errorMalformedInput: aByteString ].			unicode := ((byte1 bitAnd: 31) bitShift: 6) + (byte2 bitAnd: 63)].		(byte1 bitAnd: 16rF0) = 224 ifTrue: [ "three bytes"			byte2 := aByteString byteAt: (nextIndex := nextIndex + 1).			(byte2 bitAnd: 16rC0) = 16r80 ifFalse:[ ^self errorMalformedInput: aByteString ].			byte3 := aByteString byteAt: (nextIndex := nextIndex + 1).			(byte3 bitAnd: 16rC0) = 16r80 ifFalse:[ ^self errorMalformedInput: aByteString ].			unicode := ((byte1 bitAnd: 15) bitShift: 12) + ((byte2 bitAnd: 63) bitShift: 6)				+ (byte3 bitAnd: 63)].		(byte1 bitAnd: 16rF8) = 240 ifTrue: [ "four bytes"			byte2 := aByteString byteAt: (nextIndex := nextIndex + 1).			(byte2 bitAnd: 16rC0) = 16r80 ifFalse:[ ^self errorMalformedInput: aByteString ].			byte3 := aByteString byteAt: (nextIndex := nextIndex + 1).			(byte3 bitAnd: 16rC0) = 16r80 ifFalse:[ ^self errorMalformedInput: aByteString ].			byte4 := aByteString byteAt: (nextIndex := nextIndex + 1).			(byte4 bitAnd: 16rC0) = 16r80 ifFalse:[ ^self errorMalformedInput: aByteString ].			unicode := ((byte1 bitAnd: 16r7) bitShift: 18) +							((byte2 bitAnd: 63) bitShift: 12) + 							((byte3 bitAnd: 63) bitShift: 6) +							(byte4 bitAnd: 63)].		unicode ifNil: [ ^self errorMalformedInput: aByteString ].		unicode = 16rFEFF ifFalse: [ "Skip byte order mark"			outStream nextPut: (Unicode value: unicode) ].		lastIndex := nextIndex + 1.		(nextIndex := ByteString findFirstInString: aByteString inSet: latin1Map startingAt: lastIndex) = 0 ] whileFalse.	^outStream 		next: aByteString size - lastIndex + 1 putAll: aByteString startingAt: lastIndex;		contents! !

!UTF8TextConverter class methodsFor: 'conversion' stamp: 'ul 3/17/2010 09:54'!
encodeByteString: aByteString	"Convert the given string from UTF-8 using the fast path if converting to Latin-1"	| outStream lastIndex nextIndex |	lastIndex := 1.	(nextIndex := ByteString findFirstInString: aByteString inSet: latin1Map startingAt: lastIndex) = 0		ifTrue: [ ^aByteString ].	outStream := (String new: aByteString size + 1) writeStream.	[		outStream 			next: nextIndex - lastIndex putAll: aByteString startingAt: lastIndex;			nextPutAll: (latin1Encodings at: (aByteString byteAt: nextIndex) + 1).		lastIndex := nextIndex + 1.		(nextIndex := ByteString findFirstInString: aByteString inSet: latin1Map startingAt: lastIndex) = 0 ] whileFalse.	^outStream 		next: aByteString size - lastIndex + 1 putAll: aByteString startingAt: lastIndex;		contents! !

!UTF8TextConverter class methodsFor: 'utilities' stamp: 'yo 12/19/2003 22:01'!
encodingNames	^ #('utf-8' 'utf8') copy.! !

!UTF8TextConverter class methodsFor: 'utilities' stamp: 'ar 9/1/2010 18:16'!
errorMalformedInput: aString	"Invalid UTF-8 input has been detected in the given string.	Raise an error if strict conversions are enabled, otherwise allow	the original string to be returned."	self strictUtf8Conversions ifTrue:[		self error: 'Invalid utf8: ', aString	].	^aString! !

!UTF8TextConverter class methodsFor: 'utilities' stamp: 'ar 9/1/2010 18:16'!
strictUtf8Conversions	"Preference setter for strict utf-8 conversions"	<preference: 'Strict utf8 conversions'		category: 'general' "should this be localization?"		description: 'If true, invalid utf-8 input will raise errors. If false, invalid utf-8 input will be allowed to pass through the conversion unchanged'		type: #Boolean>		^StrictUtf8Conversions ifNil:[true]! !

!UTF8TextConverter class methodsFor: 'utilities' stamp: 'ar 9/1/2010 18:16'!
strictUtf8Conversions: aBool	"Preference setter for strict utf-8 conversions"	StrictUtf8Conversions := aBool.! !

!UTF8TextConverter class methodsFor: 'accessing' stamp: 'tak 1/12/2005 13:22'!
writeBOMOn: aStream	"Write Byte Order Mark"	aStream nextPut: 16rEF.	aStream nextPut: 16rBB.	aStream nextPut: 16rBF.! !
MultiByteFileStream initialize!
