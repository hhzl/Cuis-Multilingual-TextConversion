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
accepts: aSymbol

!MultiByteFileStream methodsFor: 'accessing' stamp: 'yo 2/21/2004 02:57'!
ascii

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 3/22/2010 07:59'!
back

!MultiByteFileStream methodsFor: 'crlf private' stamp: 'ul 1/20/2011 01:51'!
bareNext

!MultiByteFileStream methodsFor: 'private basic' stamp: 'ul 3/22/2010 07:50'!
basicBack

!MultiByteFileStream methodsFor: 'private basic' stamp: 'ul 1/28/2010 02:29'!
basicNext: anInteger

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:07'!
basicNext: n into: aString

!MultiByteFileStream methodsFor: 'private basic' stamp: 'ul 1/31/2011 02:05'!
basicNext: anInteger putAll: aCollection startingAt: startIndex

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:07'!
basicNextInto: aString

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:07'!
basicNextPut: char

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:07'!
basicNextPutAll: aString

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:07'!
basicPeek

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:08'!
basicPosition

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:08'!
basicPosition: pos

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:08'!
basicReadInto: byteArray startingAt: startIndex count: count

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:08'!
basicSetToEnd

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:08'!
basicSkip: n

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:08'!
basicUpTo: delim

!MultiByteFileStream methodsFor: 'private basic' stamp: 'yo 8/28/2002 11:09'!
basicVerbatim: aString

!MultiByteFileStream methodsFor: 'accessing' stamp: 'nice 5/10/2009 00:14'!
binary

!MultiByteFileStream methodsFor: 'crlf private' stamp: 'ul 1/30/2011 04:35'!
convertStringFromCr: aString 

!MultiByteFileStream methodsFor: 'crlf private' stamp: 'ul 1/30/2011 04:35'!
convertStringToCr: aString 

!MultiByteFileStream methodsFor: 'accessing' stamp: 'ul 1/20/2011 01:42'!
converter

!MultiByteFileStream methodsFor: 'accessing' stamp: 'nice 5/10/2009 00:18'!
converter: aConverter

!MultiByteFileStream methodsFor: 'crlf private' stamp: 'ul 1/30/2011 04:34'!
detectLineEndConvention

!MultiByteFileStream methodsFor: 'crlf private' stamp: 'ul 1/30/2011 04:35'!
doConversion

!MultiByteFileStream methodsFor: 'fileIn/Out' stamp: 'yo 8/17/2004 10:03'!
fileIn

!MultiByteFileStream methodsFor: 'accessing' stamp: 'yo 8/6/2003 11:56'!
fileInEncodingName: aString

!MultiByteFileStream methodsFor: 'fileIn/Out' stamp: 'ar 7/29/2005 22:33'!
fileInObjectAndCodeForProject

!MultiByteFileStream methodsFor: 'fileIn/Out' stamp: 'ar 7/29/2005 22:33'!
fileInProject

!MultiByteFileStream methodsFor: 'fileIn/Out' stamp: 'tak 1/12/2005 14:48'!
fileOutClass: extraClass andObject: theObject 

!MultiByteFileStream methodsFor: 'remnant' stamp: 'yo 8/28/2002 11:09'!
filterFor: aFileStream

!MultiByteFileStream methodsFor: 'initialize-release' stamp: 'ul 1/30/2011 04:28'!
initialize

!MultiByteFileStream methodsFor: 'initialize-release' stamp: 'ul 1/4/2011 07:53'!
initializeConverter

!MultiByteFileStream methodsFor: 'private' stamp: 'ul 1/30/2011 04:36'!
installLineEndConventionInConverter

!MultiByteFileStream methodsFor: 'accessing' stamp: 'nk 9/5/2004 12:57'!
lineEndConvention

!MultiByteFileStream methodsFor: 'accessing' stamp: 'nice 11/28/2009 13:06'!
lineEndConvention: aSymbol

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 1/30/2011 04:34'!
next

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 1/30/2011 04:31'!
next: anInteger 

!MultiByteFileStream methodsFor: 'crlf private' stamp: 'ul 12/27/2010 04:43'!
next: n innerFor: aString

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 1/31/2011 02:08'!
next: anInteger putAll: aCollection startingAt: startIndex

!MultiByteFileStream methodsFor: 'fileIn/Out' stamp: 'ul 2/5/2010 23:59'!
nextChunk

!MultiByteFileStream methodsFor: 'fileIn/Out' stamp: 'ul 2/7/2010 04:41'!
nextChunkText

!MultiByteFileStream methodsFor: 'public' stamp: 'yo 2/21/2004 03:26'!
nextDelimited: terminator

!MultiByteFileStream methodsFor: 'public' stamp: 'yo 8/28/2002 11:13'!
nextMatchAll: aColl

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 5/17/2011 17:30'!
nextPut: aCharacter

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 1/31/2011 02:07'!
nextPutAll: aCollection

!MultiByteFileStream methodsFor: 'open/close' stamp: 'HenrikSperreJohansen 11/20/2009 15:13'!
open: fileName forWrite: writeMode 

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 3/15/2011 13:32'!
peek

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 5/26/2010 04:03'!
peekFor: item 

!MultiByteFileStream methodsFor: 'private' stamp: 'ar 4/10/2010 20:48'!
requestDropStream: dropIndex

!MultiByteFileStream methodsFor: 'open/close' stamp: 'nice 5/10/2009 00:18'!
reset

!MultiByteFileStream methodsFor: 'private' stamp: 'ul 1/20/2011 01:55'!
setConverterForCode

!MultiByteFileStream methodsFor: 'private' stamp: 'ar 7/29/2005 22:33'!
setConverterForCodeForProject

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 3/27/2010 00:04'!
skipSeparators

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 3/27/2010 16:19'!
skipSeparatorsAndPeekNext

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 12/4/2009 19:08'!
upTo: delimiter

!MultiByteFileStream methodsFor: 'public' stamp: 'nice 12/7/2009 08:26'!
upToAnyOf: delimiters do: aBlock

!MultiByteFileStream methodsFor: 'public' stamp: 'ul 12/6/2009 04:18'!
upToEnd

!MultiByteFileStream methodsFor: 'crlf private' stamp: 'ul 1/30/2011 04:31'!
wantsLineEndConversion

!MultiByteFileStream methodsFor: 'remnant' stamp: 'ul 1/30/2011 04:35'!
wantsLineEndConversion: aBoolean

!MultiByteFileStream class methodsFor: 'class initialization' stamp: 'yo 2/21/2004 02:45'!
defaultToCR

!MultiByteFileStream class methodsFor: 'class initialization' stamp: 'yo 2/21/2004 02:45'!
defaultToCRLF

!MultiByteFileStream class methodsFor: 'class initialization' stamp: 'yo 2/21/2004 02:46'!
defaultToLF

!MultiByteFileStream class methodsFor: 'class initialization' stamp: 'nice 11/27/2009 22:01'!
guessDefaultLineEndConvention

!MultiByteFileStream class methodsFor: 'class initialization' stamp: 'yo 2/21/2004 02:44'!
initialize

!MultiByteFileStream class methodsFor: 'accessing' stamp: 'cmm 10/10/2010 19:17'!
lineEndDefault

!MultiByteFileStream class methodsFor: 'as yet unclassified' stamp: 'ul 1/20/2011 02:18'!
newForStdio

!MultiByteFileStream class methodsFor: 'instance creation' stamp: 'yo 8/28/2002 11:43'!
newFrom: aFileStream

!MultiByteFileStream class methodsFor: 'class initialization' stamp: 'yo 2/21/2004 02:44'!
startUp

!UTF8TextConverter methodsFor: 'conversion' stamp: 'ul 3/22/2010 08:18'!
backFromStream: aStream

!UTF8TextConverter methodsFor: 'conversion' stamp: 'ul 3/17/2010 10:06'!
decodeString: aString

!UTF8TextConverter methodsFor: 'conversion' stamp: 'ul 3/17/2010 10:07'!
encodeString: aString

!UTF8TextConverter methodsFor: 'conversion' stamp: 'ar 9/1/2010 18:21'!
errorMalformedInput: aString

!UTF8TextConverter methodsFor: 'friend' stamp: 'yo 11/8/2002 16:17'!
leadingChar

!UTF8TextConverter methodsFor: 'fileIn/Out' stamp: 'ul 3/27/2010 00:12'!
nextChunkFromStream: input

!UTF8TextConverter methodsFor: 'fileIn/Out' stamp: 'ul 3/27/2010 00:11'!
nextChunkTextFromStream: input

!UTF8TextConverter methodsFor: 'conversion' stamp: 'ar 9/1/2010 18:21'!
nextFromStream: aStream

!UTF8TextConverter methodsFor: 'conversion' stamp: 'ul 5/17/2011 17:25'!
nextPut: aCharacter toStream: aStream 

!UTF8TextConverter methodsFor: 'fileIn/Out' stamp: 'ul 3/27/2010 00:09'!
parseLangTagFor: aString fromStream: stream

!UTF8TextConverter methodsFor: 'fileIn/Out' stamp: 'ul 3/27/2010 16:44'!
skipSeparatorsAndPeekNextFrom: aStream

!UTF8TextConverter methodsFor: 'fileIn/Out' stamp: 'ul 3/27/2010 00:04'!
skipSeparatorsFrom: aStream

!UTF8TextConverter class methodsFor: 'conversion' stamp: 'ar 9/1/2010 18:11'!
decodeByteString: aByteString

!UTF8TextConverter class methodsFor: 'conversion' stamp: 'ul 3/17/2010 09:54'!
encodeByteString: aByteString

!UTF8TextConverter class methodsFor: 'utilities' stamp: 'yo 12/19/2003 22:01'!
encodingNames

!UTF8TextConverter class methodsFor: 'utilities' stamp: 'ar 9/1/2010 18:16'!
errorMalformedInput: aString

!UTF8TextConverter class methodsFor: 'utilities' stamp: 'ar 9/1/2010 18:16'!
strictUtf8Conversions

!UTF8TextConverter class methodsFor: 'utilities' stamp: 'ar 9/1/2010 18:16'!
strictUtf8Conversions: aBool

!UTF8TextConverter class methodsFor: 'accessing' stamp: 'tak 1/12/2005 13:22'!
writeBOMOn: aStream
MultiByteFileStream initialize!