Cuis-Multilingual-TextConversion

================================




Port of classes from Squeak to allow Cuis Smalltalk to read and write text files in different encodings.


### Status

Initial load and made some test cases to work


MultiLingualUnicodeTest>>testUTF8ReadContentsOfEntireFile

    testUTF8ReadContentsOfEntireFile
    "self new testUTF8ReadContentsOfEntireFile"
	
    | stream |

     stream := MultiByteFileStream readOnlyFileNamed: self class fileName.

    self assert: stream contentsOfEntireFile = 'abc ‡Ë§ &#945;&#946;&#947;'


The Strings in Cuis are still ByteStrings (8 bit characters) after loading this Add-On. Unicode characters are shown as HTML number entities in case they do not fall in the supported set of characters in Cuis.

.