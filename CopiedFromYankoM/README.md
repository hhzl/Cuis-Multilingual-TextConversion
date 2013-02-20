Source: http://forum.world.st/Unicode-patch-tt64011.html

 Jun 12, 2007; 5:24pm Janko Mivšek Janko Mivšek Unicode patch
Dear Squeakers,

Please find attached an Unicode patch, which deals with improvements of
internal representation of Unicode characters. It:

1. introduce new class TwoByteString
2. change at:put: on ByteString and other such methods to "scale" string
    to TwoByteString or FourByteString, depending on width of a character
3. rename WideString to FourByteString for consistency, also
    rename all related methods
2. add category CollectionTests-Unicode with tests
3. add class UnicodeBenchmarking for measuring speed of
    Unicode handling like at:put speed and UTF8 conversions on included
    English, French, Slovenian, Russian and Chinese text.

ByteString and TwoByteString also include UTF8 conversion methods, which
will probably be moved to UTF8TextConverter later.

I hope this patch will help improving Squeak Unicode support a bit.

Best regards
Janko


-- 
Janko Mivšek
AIDA/Web
Smalltalk Web Application Server
http://www.aidaweb.si




