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
    Deltics.StringTypes;


  {$i deltics.stringtypes.aliases.inc}

  type
    THexCase = (hexLowercase, hexUppercase);

    Hex2Bin = class
    public
      class procedure ToHex(const aBuffer: Pointer; const aNumBytes: Integer; const aOutBuffer: PAnsiChar; const aCase: THexCase = hexLowercase); overload;
      class procedure ToHex(const aBuffer: Pointer; const aNumBytes: Integer; const aOutBuffer: PUtf8Char; const aCase: THexCase = hexLowercase); overload;
      class procedure ToHex(const aBuffer: Pointer; const aNumBytes: Integer; const aOutBuffer: PWideChar; const aCase: THexCase = hexLowercase); overload;

      class procedure ToHex(const aBuffer: Pointer; const aNumBytes: Integer; var aString: AnsiString; const aCase: THexCase = hexLowercase); overload;
      class procedure ToHex(const aBuffer: Pointer; const aNumBytes: Integer; var aString: UnicodeString; const aCase: THexCase = hexLowercase); overload;
    {$ifdef UNICODE}
      class procedure ToHex(const aBuffer: Pointer; const aNumBytes: Integer; var aString: Utf8String; const aCase: THexCase = hexLowercase); overload;
    {$endif}
      class procedure ToHex(const aBuffer: Pointer; const aNumBytes: Integer; var aString: WideString; const aCase: THexCase = hexLowercase); overload;

      class function ToHex(const aBuffer: Pointer; const aNumBytes: Integer; const aCase: THexCase = hexLowercase): String; overload;
      class function ToHexA(const aBuffer: Pointer; const aNumBytes: Integer; const aCase: THexCase = hexLowercase): AnsiString;
      class function ToHexW(const aBuffer: Pointer; const aNumBytes: Integer; const aCase: THexCase = hexLowercase): UnicodeString;

      class procedure ToHexUtf8(const aBuffer: Pointer; const aNumBytes: Integer; var aString: Utf8String; const aCase: THexCase = hexLowercase); overload;
      class function ToHexUtf8(const aBuffer: Pointer; const aNumBytes: Integer; const aCase: THexCase = hexLowercase): Utf8String; overload;

      class procedure ToBin(const aBuffer: PAnsiChar; const aNumChars: Integer; const aOutBuffer: Pointer); overload;
      class procedure ToBin(const aBuffer: PUtf8Char; const aNumChars: Integer; const aOutBuffer: Pointer); overload;
      class procedure ToBin(const aBuffer: PWideChar; const aNumChars: Integer; const aOutBuffer: Pointer); overload;
      class procedure ToBin(const aString: AnsiString; const aOutBuffer: Pointer); overload;
      class procedure ToBin(const aString: UnicodeString; const aOutBuffer: Pointer); overload;
    {$ifdef UNICODE}
      class procedure ToBin(const aString: Utf8String; const aOutBuffer: Pointer); overload;
    {$endif}
      class procedure ToBinUtf8(const aString: Utf8String; const aOutBuffer: Pointer);
    end;


implementation

  uses
    Deltics.Exceptions,
    Deltics.Memory;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Hex2Bin.ToHex(const aBuffer: Pointer;
                                const aNumBytes: Integer;
                                const aOutBuffer: PAnsiChar;
                                const aCase: THexCase);
  const
    DIGITS: array[FALSE..TRUE] of AnsiString = ('0123456789abcdef', '0123456789ABCDEF');
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
      pOut^ := DIGITS[aCase = hexUppercase][(pBuf^ and $0f) + 1];
      Dec(pOut);

      pOut^ := DIGITS[aCase = hexUppercase][(pBuf^ and $f0) shr 4 + 1];
      Dec(pOut);

      Inc(pBuf);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Hex2Bin.ToHex(const aBuffer: Pointer; const aNumBytes: Integer; const aOutBuffer: PUtf8Char; const aCase: THexCase);
  const
    DIGITS: array[FALSE..TRUE] of Utf8String = ('0123456789abcdef', '0123456789ABCDEF');
  var
    i: Integer;
    pBuf: PByte;
    pOut: PUtf8Char;
  begin
    pBuf := aBuffer;
  {$ifdef 64BIT}
    pOut := PUtf8Char(Int64(aOutBuffer) + (aNumBytes * 2) - 1);
  {$else}
    pOut := PUtf8Char(Integer(aOutBuffer) + (aNumBytes * 2) - 1);
  {$endif}

    for i := aNumBytes downto 1 do
    begin
      pOut^ := DIGITS[aCase = hexUppercase][(pBuf^ and $0f) + 1];
      Dec(pOut);

      pOut^ := DIGITS[aCase = hexUppercase][(pBuf^ and $f0) shr 4 + 1];
      Dec(pOut);

      Inc(pBuf);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Hex2Bin.ToHex(const aBuffer: Pointer;
                                const aNumBytes: Integer;
                                const aOutBuffer: PWideChar;
                                const aCase: THexCase);
  const
    DIGITS: array[FALSE..TRUE] of UnicodeString = ('0123456789abcdef', '0123456789ABCDEF');
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
      pOut^ := DIGITS[aCase = hexUppercase][(pBuf^ and $0f) + 1];
      Dec(pOut);

      pOut^ := DIGITS[aCase = hexUppercase][(pBuf^ and $f0) shr 4 + 1];
      Dec(pOut);

      Inc(pBuf);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Hex2Bin.ToHex(const aBuffer: Pointer; const aNumBytes: Integer; const aCase: THexCase): String;
  begin
    ToHex(aBuffer, aNumBytes, result, aCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Hex2Bin.ToHex(const aBuffer: Pointer; const aNumBytes: Integer; var aString: AnsiString; const aCase: THexCase);
  begin
    SetLength(aString, aNumBytes * 2);
    ToHex(aBuffer, aNumBytes, PAnsiChar(aString), aCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Hex2Bin.ToHex(const aBuffer: Pointer; const aNumBytes: Integer; var aString: UnicodeString; const aCase: THexCase);
  begin
    SetLength(aString, aNumBytes * 2);
    ToHex(aBuffer, aNumBytes, PWideChar(aString), aCase);
  end;


{$ifdef UNICODE}
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Hex2Bin.ToHex(const aBuffer: Pointer; const aNumBytes: Integer; var aString: Utf8String; const aCase: THexCase);
  begin
    SetLength(aString, aNumBytes * 2);
    ToHex(aBuffer, aNumBytes, PUtf8Char(aString), aCase);
  end;
{$endif}


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Hex2Bin.ToHex(const aBuffer: Pointer; const aNumBytes: Integer; var aString: WideString; const aCase: THexCase);
  begin
    SetLength(aString, aNumBytes * 2);
    ToHex(aBuffer, aNumBytes, PWideChar(aString), aCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Hex2Bin.ToHexA(const aBuffer: Pointer; const aNumBytes: Integer; const aCase: THexCase): AnsiString;
  begin
    ToHex(aBuffer, aNumBytes, result, aCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Hex2Bin.ToHexW(const aBuffer: Pointer; const aNumBytes: Integer; const aCase: THexCase): UnicodeString;
  begin
    ToHex(aBuffer, aNumBytes, result, aCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Hex2Bin.ToHexUtf8(const aBuffer: Pointer; const aNumBytes: Integer; var aString: Utf8String; const aCase: THexCase);
  begin
    SetLength(aString, aNumBytes * 2);
    ToHex(aBuffer, aNumBytes, Putf8Char(aString), aCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Hex2Bin.ToHexUtf8(const aBuffer: Pointer; const aNumBytes: Integer; const aCase: THexCase): Utf8String;
  begin
    ToHexUtf8(aBuffer, aNumBytes, result, aCase);
  end;








  const
    HEX_DIGITS  : set of AnsiChar = ['0'..'9', 'A'..'F', 'a'..'f'];
    HEX_ORDS    : array['0'..'f'] of SmallInt =
    ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15);


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Hex2Bin.ToBin(const aBuffer: PAnsiChar;
                                const aNumChars: Integer;
                                const aOutBuffer: Pointer);
  var
    i: Integer;
    pCharHi: PAnsiChar;
    pCharLo: PAnsiChar;
    pOut: PByte;
  begin
    pOut := PByte(aOutBuffer);
    pCharHi := PAnsiChar(Memory.Offset(aBuffer, aNumChars - 1));
    pCharLo := pCharHi;
    Dec(pCharHi);

    for i := 1 to aNumChars div 2 do
    begin
      if NOT (pCharHi^ in HEX_DIGITS) then
        raise EArgumentException.CreateFmt('Invalid character ''%s''', [pCharHi^]);

      if NOT (pCharLo^ in HEX_DIGITS) then
        raise EArgumentException.CreateFmt('Invalid character ''%s''', [pCharLo^]);

      pOut^ := Byte((HEX_ORDS[pCharHi^] shl 4) or HEX_ORDS[pCharLo^]);
      Inc(pOut);
      Dec(pCharHi, 2);
      Dec(pCharLo, 2);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Hex2Bin.ToBin(const aBuffer: PUtf8Char;
                                const aNumChars: Integer;
                                const aOutBuffer: Pointer);
  begin
    ToBin(PAnsiChar(aBuffer), aNumChars, aOutBuffer);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Hex2Bin.ToBin(const aBuffer: PWideChar;
                                const aNumChars: Integer;
                                const aOutBuffer: Pointer);
  var
    i: Integer;
    pCharHi: PWideChar;
    pCharLo: PWideChar;
    pOut: PByte;
  begin
    pOut := PByte(aOutBuffer);
    pCharHi := PWideChar(Memory.Offset(aBuffer, (aNumChars - 1) * 2));
    pCharLo := pCharHi;
    Dec(pCharHi);

    for i := 1 to aNumChars div 2 do
    begin
      if (Word(pCharHi^) > $0100) or NOT (AnsiChar(pCharHi^) in HEX_DIGITS) then
        raise EArgumentException.CreateFmt('Invalid character ''%s''', [pCharHi^]);

      if (Word(pCharLo^) > $0100) or NOT (AnsiChar(pCharLo^) in HEX_DIGITS) then
        raise EArgumentException.CreateFmt('Invalid character ''%s''', [pCharLo^]);

      pOut^ := Byte((HEX_ORDS[AnsiChar(pCharHi^)] shl 4) or HEX_ORDS[AnsiChar(pCharLo^)]);
      Inc(pOut);
      Dec(pCharHi, 2);
      Dec(pCharLo, 2);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Hex2Bin.ToBin(const aString: AnsiString;
                                const aOutBuffer: Pointer);
  begin
    ToBin(PAnsiChar(aString), Length(aString), aOutBuffer);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Hex2Bin.ToBin(const aString: UnicodeString;
                                const aOutBuffer: Pointer);
  begin
    ToBin(PWideChar(aString), Length(aString), aOutBuffer);
  end;


{$ifdef UNICODE}
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Hex2Bin.ToBin(const aString: Utf8String;
                                const aOutBuffer: Pointer);
  begin
    ToBin(PAnsiChar(aString), Length(aString), aOutBuffer);
  end;
{$endif}


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Hex2Bin.ToBinUtf8(const aString: Utf8String;
                                    const aOutBuffer: Pointer);
  begin
    ToBin(PAnsiChar(aString), Length(aString), aOutBuffer);
  end;



end.
