{
  * MIT LICENSE *

  Copyright � 2020 Jolyon Smith

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

{$i deltics.hex.inc}

  unit Deltics.Hex;


interface


  function BinToHex(const aBuf: Pointer; const aSize: Integer): String; overload;
  procedure BinToHex(const aBuf: Pointer; const aSize: Integer; var aWideString: WideString); overload;
{$ifdef UNICODE}
  procedure BinToHex(const aBuf: Pointer; const aSize: Integer; var aAnsiString: AnsiString); overload;
{$endif}

  function BinToHex(const aInt: Integer): String; overload;
  procedure BinToHex(const aInt: Integer; var aWideString: WideString); overload;
{$ifdef UNICODE}
  procedure BinToHex(const aInt: Integer; var aAnsiString: AnsiString); overload;
{$endif}

  function HexToBin(const aString: String): Pointer; overload;
  function HexToBin(const aString: WideString): Pointer; overload;
{$ifdef UNICODE}
  function HexToBin(const aString: AnsiString): Pointer; overload;
{$endif}

  function HexToBin(const aString: String; var aSize: Integer): Pointer; overload;
  function HexToBin(const aString: WideString; var aSize: Integer): Pointer; overload;
{$ifdef UNICODE}
  function HexToBin(const aString: AnsiString; var aSize: Integer): Pointer; overload;
{$endif}

  procedure HexToBin(const aString: String; var aBuf; const aSize: Integer); overload;
  procedure HexToBin(const aString: WideString; var aBuf; const aSize: Integer); overload;
{$ifdef UNICODE}
  procedure HexToBin(const aString: AnsiString; var aBuf; const aSize: Integer); overload;
{$endif}


implementation

  uses
    Deltics.Exceptions;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function BinToHex(const aBuf: Pointer;
                    const aSize: Integer): String;
  const
    DIGITS: String = '0123456789abcdef';
  var
    i: Integer;
    c: PByte;
    ci: Integer;
  begin
    SetLength(result, aSize * 2);

    c := aBuf;
    for i := aSize downto 1 do
    begin
      ci := i * 2;
      result[ci - 1]  := DIGITS[(c^ and $F0) shr 4 + 1];
      result[ci]      := DIGITS[(c^ and $0F) + 1];
      Inc(c);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure BinToHex(const aBuf: Pointer; const aSize: Integer; var aWideString: WideString);
  const
    DIGITS: WideString = '0123456789abcdef';
  var
    i: Integer;
    c: PByte;
    ci: Integer;
  begin
    SetLength(aWideString, aSize * 2);

    c := aBuf;
    for i := aSize downto 1 do
    begin
      ci := i * 2;
      aWideString[ci - 1]  := DIGITS[(c^ and $F0) shr 4 + 1];
      aWideString[ci]      := DIGITS[(c^ and $0F) + 1];
      Inc(c);
    end;
  end;


{$ifdef UNICODE}
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure BinToHex(const aBuf: Pointer; const aSize: Integer; var aAnsiString: AnsiString);
  const
    DIGITS: AnsiString = '0123456789abcdef';
  var
    i: Integer;
    c: PByte;
    ci: Integer;
  begin
    SetLength(aAnsiString, aSize * 2);

    c := aBuf;
    for i := aSize downto 1 do
    begin
      ci := i * 2;
      aAnsiString[ci - 1]  := DIGITS[(c^ and $F0) shr 4 + 1];
      aAnsiString[ci]      := DIGITS[(c^ and $0F) + 1];
      Inc(c);
    end;
  end;
{$endif}




  function BinToHex(const aInt: Integer): String;
  begin
    result := BinToHex(@aInt, sizeof(Integer));
  end;


  procedure BinToHex(const aInt: Integer; var aWideString: WideString);
  begin
    BinToHex(@aInt, sizeof(Integer), aWideString);
  end;


{$ifdef UNICODE}
  procedure BinToHex(const aInt: Integer; var aAnsiString: AnsiString);
  begin
    BinToHex(@aInt, sizeof(Integer), aAnsiString);
  end;
{$endif}







  const
    HEX_DIGITS  = ['0'..'9', 'A'..'F', 'a'..'f'];
    HEX_ORDS    : array['0'..'f'] of SmallInt =
    ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15);


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function HexToBin(const aString: String): Pointer;
  var
    notUsed: Integer;
  begin
    result := HexToBin(aString, notUsed);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function HexToBin(const aString: WideString): Pointer; overload;
  var
    notUsed: Integer;
  begin
    result := HexToBin(aString, notUsed);
  end;


{$ifdef UNICODE}
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function HexToBin(const aString: AnsiString): Pointer; overload;
  var
    notUsed: Integer;
  begin
    result := HexToBin(aString, notUsed);
  end;
{$endif}




  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function HexToBin(const aString: String;
                    var   aSize: Integer): Pointer;
  begin
    result  := NIL;
    aSize   := Length(aString) div 2;

    if aSize = 0 then
      EXIT;

    GetMem(result, aSize);

    HexToBin(aString, result^, aSize);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function HexToBin(const aString: WideString;
                    var   aSize: Integer): Pointer;
  begin
    result  := NIL;
    aSize   := Length(aString) div 2;

    if aSize = 0 then
      EXIT;

    GetMem(result, aSize);

    HexToBin(aString, result^, aSize);
  end;


{$ifdef UNICODE}
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function HexToBin(const aString: AnsiString;
                    var   aSize: Integer): Pointer;
  begin
    result  := NIL;
    aSize   := Length(aString) div 2;

    if aSize = 0 then
      EXIT;

    GetMem(result, aSize);

    HexToBin(aString, result^, aSize);
  end;
{$endif}


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure HexToBin(const aString: String;
                     var   aBuf;
                     const aSize: Integer);
  var
    i: Integer;
    ci: Integer;
    c: AnsiChar;
    n: AnsiChar;
    pbuf: PByte;
  begin
    pbuf := PByte(@aBuf);

    for i := aSize downto 1 do
    begin
      ci := ((i - 1) * 2) + 1;

      c := AnsiChar(aString[ci]);
      n := AnsiChar(aString[ci + 1]);

      if NOT (c in HEX_DIGITS) then
        raise EArgumentException.CreateFmt('Invalid character ''%s'' in hex string ''%s''', [c, aString]);

      if NOT (n in HEX_DIGITS) then
        raise EArgumentException.CreateFmt('Invalid character ''%s'' in hex string ''%s''', [n, aString]);

      pbuf^ := Byte((HEX_ORDS[c] shl 4) or HEX_ORDS[n]);
      Inc(pbuf);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure HexToBin(const aString: WideString;
                     var   aBuf;
                     const aSize: Integer);
  var
    i: Integer;
    ci: Integer;
    c: AnsiChar;
    n: AnsiChar;
    pbuf: PByte;
  begin
    pbuf := PByte(@aBuf);

    for i := aSize downto 1 do
    begin
      ci := ((i - 1) * 2) + 1;

      c := AnsiChar(aString[ci]);
      n := AnsiChar(aString[ci + 1]);

      if NOT (c in HEX_DIGITS) then
        raise EArgumentException.CreateFmt('Invalid character ''%s'' in hex string ''%s''', [c, aString]);

      if NOT (n in HEX_DIGITS) then
        raise EArgumentException.CreateFmt('Invalid character ''%s'' in hex string ''%s''', [n, aString]);

      pbuf^ := Byte((HEX_ORDS[c] shl 4) or HEX_ORDS[n]);
      Inc(pbuf);
    end;
  end;



{$ifdef UNICODE}
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure HexToBin(const aString: AnsiString;
                     var   aBuf;
                     const aSize: Integer);
  var
    i: Integer;
    ci: Integer;
    c: AnsiChar;
    n: AnsiChar;
    pbuf: PByte;
  begin
    pbuf := PByte(@aBuf);

    for i := aSize downto 1 do
    begin
      ci := ((i - 1) * 2) + 1;

      c := aString[ci];
      n := aString[ci + 1];

      if NOT (c in HEX_DIGITS) then
        raise EArgumentException.CreateFmt('Invalid character ''%s'' in hex string ''%s''', [c, aString]);

      if NOT (n in HEX_DIGITS) then
        raise EArgumentException.CreateFmt('Invalid character ''%s'' in hex string ''%s''', [n, aString]);

      pbuf^ := Byte((HEX_ORDS[c] shl 4) or HEX_ORDS[n]);
      Inc(pbuf);
    end;
  end;
{$endif}


end.
