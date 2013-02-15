Cuis-Multilingual-TextConversion
----------------------------------------


The files in this repository serve for a port of classes from Squeak to allow Cuis Smalltalk 
to read and write text files in different encodings.

However as of Cuis version 4.1-1590 it is not all that necessary to go for this 
as there is an update which allows Cuis to read and write UTF8 text files losslessly. For details see below.

As of now Cuis 4.1-1590 and later may read and write UTF8 text files losslessly without needing any additional package.

To read an UTF8 file in Cuis 4.1-1590 execute

    String fromUtf8:
       (FileStream fileNamed: 'anUTF8file.txt') contentsOfEntireFile


To write an UTF8 file execute

    | theContent |
    
    theContent := 'some String which may contain NCRs'.
    
    (FileStream forceNewFileNamed:  'aFileName.txt')
        binary;
        nextPutAll: (theContent asUtf8: true);   
        " 'true' means 'convert Numerical Character References back to UTF8'   "
        close.

Ref: NCR, see http://en.wikipedia.org/wiki/Numeric_character_reference

	

### Status of this package

The aim of the package here is to go for a TextConverter and UTF8TextConverter class as in Squeak.	

Initial load and made some test cases to work


MultiLingualUnicodeTest>>testUTF8ReadContentsOfEntireFile


    testUTF8ReadContentsOfEntireFile
    "self new testUTF8ReadContentsOfEntireFile"
	
    | stream |

     stream := MultiByteFileStream readOnlyFileNamed: self class fileName.

    self assert: stream contentsOfEntireFile = 'abc �� &#945;&#946;&#947;'


The Strings in Cuis are still ByteStrings (8 bit characters) after loading this Add-On. 
Unicode characters are shown as HTML number entities in case 
they do not fall in the supported set of characters in Cuis.

Because of the Cuis change set 4.1-1590 the development of this package is put on hold for the moment. 
It may be later resumed because of the need for an UTF8TextConverter class for compatibiliy reasons.


### Cuis change set 4.1-1590

The update
https://github.com/jvuletich/Cuis/blob/master/UpdatesSinceLastRelease/1590-InvertibleUTF8Conversion-JuanVuletich-2013Feb08-08h11m-jmv.1.cs.st

mainly introduces the methods

    String>>asUtf8: 
	String class>>fromUtf8:
	
The change set removes the former class methods of Integer

    Integer class>>evaluate:withUtf8BytesOfUnicodecodePoint:
    Integer class>>nextUnicodeCodePointFromUtf8:
    Integer class>>unicodeCodePointOfUtf8Bytes:
    Integer class>>utf8BytesOfUnicodeCodePoint:

The Character class has the following Unicode/UTF8 related methods

    Character class>>evaluate: aBlock withUtf8BytesOfUnicodeCodePoint: aCodePoint
    Character class>>nextUnicodeCodePointFromUtf8: anUtf8Stream
    Character class>>unicodeCodePoint: codePoint
    Character class>>unicodeCodePointOfUtf8Bytes: aByteArray
    Character class>>utf8BytesOfUnicodeCodePoint: aCodePoint
	
Details see: 
    https://github.com/hhzl/Cuis-Add-Ons/blob/master/UnicodeNotes.md	

The class UnicodeTest4dot1dash1590 contained in 
    UnicodeTest4dot1dash1590.st
demonstrates the use of the methods _#asUtf8:_ and _#fromUtf8:_

