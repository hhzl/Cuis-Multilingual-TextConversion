Cuis-Multilingual-TextConversion
----------------------------------------

### Aim

The files in this repository serve for a port of classes 
- UTF8TextConverter
- MultiByteFileStream

from Squeak/Pharo to allow Cuis Smalltalk 
to read and write text files in UTF8 encodings. As the code converters 
form a small framework more encodings may be added from Squeak or Pharo as needed.

Note that for version 4.1-1590 and later allows Cuis to read and write UTF8 text files losslessly without 
using these classes. For details about change set 1590 see section below.


### Status

alpha; initial load done and made some test cases to work


MultiLingualUnicodeTest>>testUTF8ReadContentsOfEntireFile


    testUTF8ReadContentsOfEntireFile
      "self new testUTF8ReadContentsOfEntireFile"
	
      | stream |

      stream := MultiByteFileStream readOnlyFileNamed: self class fileName.

      self assert: stream contentsOfEntireFile = 'abc �� &#945;&#946;&#947;'


Note that in this README.md file the test string is not proplerly displayed as it is UTF8 whereas in 
Cuis we have ISO8859-15 with NCRs.


Because of the Cuis change set 4.1-1590 the development of this package is put on hold for the moment. 
It may be later resumed because of the need for an UTF8TextConverter and
MultiByteFileStream class for compatibiliy reasons.



### UTF8 reading and writing in Cuis

To read an UTF8 file in Cuis 4.1-1590 without this package beein present execute

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

	

### Strings in Cuis and Unicode


The Strings in Cuis are still ByteStrings (8 bit characters) after loading this Add-On. 
Unicode characters are shown as HTML number entities in case 
they do not fall in the supported set of characters in Cuis.


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



### Code archive

This repository contains some code archived from Pharo, Squeak and from Janko Mivšek <janko.mivsek@eranova.si.
It shows the status in Pharo and Squeak. The other code is a proposal for a two byte Unicode solution.

