{
  * MIT LICENSE *

  Copyright © 2020 Jolyon Smith

  Permission is hereby granted, free of charge, to any person obtaining a copy of
   this software and associated documentation files (the "Software"), to deal in
   the Software without restriction, including without limitation the rights to
   use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
   of the Software, and to permit persons to whom the Software is furnished to do
   so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.


  * GPL and Other Licenses *

  The FSF deem this license to be compatible with version 3 of the GPL.
   Compatability with other licenses should be verified by reference to those
   other license terms.


  * Contact Details *

  Original author : Jolyon Direnko-Smith
  e-mail          : jsmith@deltics.co.nz
  github          : deltics/deltics.rtl
}

{$i deltics.hex2bin.inc}

  unit Deltics.Hex2Bin;


interface

  uses
    Deltics.Strings;


  procedure BinToHex(const aBuffer: Pointer; const aNumBytes: Integer; aOutBuffer: PAnsiChar); overload;
  procedure BinToHex(const aBuffer: Pointer; const aNumBytes: Integer; aOutBuffer: PWideChar); overload;

  function BinToHex(const aBuffer: Pointer; const aNumBytes: Integer): String; overload;
  procedure BinToHex(const aBuffer: Pointer; const aNumBytes: Integer; var aString: AnsiString); overload;
  procedure BinToHex(const aBuffer: Pointer; const aNumBytes: Integer; var aString: UnicodeString); overload;
  procedure BinToHex(const aBuffer: Pointer; const aNumBytes: Integer; var aString: WideString); overload;
  function BinToHexA(const aBuffer: Pointer; const aNumBytes: Integer): AnsiString;
  function BinToHexW(const aBuffer: Pointer; const aNumBytes: Integer): UnicodeString;

  procedure HexToBin(const aString: AnsiString; const aOutBuffer: Pointer); overload;
  procedure HexToBin(const aString: UnicodeString; const aOutBuffer: Pointer); overload;


implementation

  uses
    Deltics.Exceptions;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure BinToHex(const aBuffer: Pointer;
                     const aNumBytes: Integer;
                           aOutBuffer: PAnsiChar);
  const
    DIGITS: AnsiString = '0123456789abcdef';
  var
    i: Integer;
    pBuf: PByte;
    pOut: PAnsiChar;
  begin
    pBuf := aBuffer;
  {$ifdef 64BIT}
    pOut := PAnsiChar(Int64(aOutBuffer) + (aNumBytes * 2) - 1);
  {$else}
    pOut := PAnsiChar(Integer(aOutBuffer) + (aNumBytes * 2) - 1);
  {$endif}

    for i := aNumBytes downto 1 do
    begin
      pOut^ := DIGITS[(pBuf^ and $0f) + 1];
      Dec(pOut);

      pOut^ := DIGITS[(pBuf^ and $f0) shr 4 + 1];
      Dec(pOut);

      Inc(pBuf);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure BinToHex(const aBuffer: Pointer;
                     const aNumBytes: Integer;
                           aOutBuffer: PWideChar);
  const
    DIGITS: UnicodeString = '0123456789abcdef';
  var
    i: Integer;
    pBuf: PByte;
    pOut: PWideChar;
  begin
    pBuf := aBuffer;
  {$ifdef 64BIT}
    pOut := PWideChar(Int64(aOutBuffer) + (aNumBytes * 4) - 2);
  {$else}
    pOut := PWideChar(Integer(aOutBuffer) + (aNumBytes * 4) - 2);
  {$endif}

    for i := aNumBytes downto 1 do
    begin
      pOut^ := DIGITS[(pBuf^ and $0f) + 1];
      Dec(pOut);

      pOut^ := DIGITS[(pBuf^ and $f0) shr 4 + 1];
      Dec(pOut);

      Inc(pBuf);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function BinToHex(const aBuffer: Pointer; const aNumBytes: Integer): String;
  begin
    BinToHex(aBuffer, aNumBytes, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function BinToHexA(const aBuffer: Pointer; const aNumBytes: Integer): AnsiString;
  begin
    BinToHex(aBuffer, aNumBytes, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function BinToHexW(const aBuffer: Pointer; const aNumBytes: Integer): UnicodeString;
  begin
    BinToHex(aBuffer, aNumBytes, result);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure BinToHex(const aBuffer: Pointer; const aNumBytes: Integer; var aString: AnsiString);
  begin
    SetLength(aString, aNumBytes * 2);
    BinToHex(aBuffer, aNumBytes, PAnsiChar(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure BinToHex(const aBuffer: Pointer; const aNumBytes: Integer; var aString: UnicodeString);
  begin
    SetLength(aString, aNumBytes * 2);
    BinToHex(aBuffer, aNumBytes, PWideChar(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure BinToHex(const aBuffer: Pointer; const aNumBytes: Integer; var aString: WideString);
  begin
    SetLength(aString, aNumBytes * 2);
    BinToHex(aBuffer, aNumBytes, PWideChar(aString));
  end;








  const
    HEX_DIGITS  = ['0'..'9', 'A'..'F', 'a'..'f'];
    HEX_ORDS    : array['0'..'f'] of SmallInt =
    ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15);


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure HexToBin(const aString: AnsiString;
                     const aOutBuffer: Pointer);
  var
    i: Integer;
    pCharHi: PAnsiChar;
    pCharLo: PAnsiChar;
    pOut: PByte;
  begin
    pOut := PByte(aOutBuffer);
    pCharHi := PAnsiChar(@aString[Length(aString)]);
    pCharLo := pCharHi;
    Dec(pCharHi);

    for i := 1 to Length(aString) div 2 do
    begin
      if NOT (pCharHi^ in HEX_DIGITS) then
        raise EArgumentException.CreateFmt('Invalid character ''%s'' in hex string ''%s''', [pCharHi^, aString]);

      if NOT (pCharLo^ in HEX_DIGITS) then
        raise EArgumentException.CreateFmt('Invalid character ''%s'' in hex string ''%s''', [pCharLo^, aString]);

      pOut^ := Byte((HEX_ORDS[pCharHi^] shl 4) or HEX_ORDS[pCharLo^]);
      Inc(pOut);
      Dec(pCharHi, 2);
      Dec(pCharLo, 2);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure HexToBin(const aString: UnicodeString;
                     const aOutBuffer: Pointer);
  var
    i: Integer;
    pCharHi: PWideChar;
    pCharLo: PWideChar;
    pOut: PByte;
  begin
    pOut := PByte(aOutBuffer);
    pCharHi := PWideChar(@aString[Length(aString)]);
    pCharLo := pCharHi;
    Dec(pCharHi);

    for i := 1 to Length(aString) div 2 do
    begin
      if (Word(pCharHi^) > $0100) or NOT (AnsiChar(pCharHi^) in HEX_DIGITS) then
        raise EArgumentException.CreateFmt('Invalid character ''%s'' in hex string ''%s''', [pCharHi^, aString]);

      if (Word(pCharLo^) > $0100) or NOT (AnsiChar(pCharLo^) in HEX_DIGITS) then
        raise EArgumentException.CreateFmt('Invalid character ''%s'' in hex string ''%s''', [pCharLo^, aString]);

      pOut^ := Byte((HEX_ORDS[AnsiChar(pCharHi^)] shl 4) or HEX_ORDS[AnsiChar(pCharLo^)]);
      Inc(pOut);
      Dec(pCharHi, 2);
      Dec(pCharLo, 2);
    end;
  end;





end.
