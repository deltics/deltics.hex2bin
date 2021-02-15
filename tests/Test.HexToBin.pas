
{$i deltics.inc}

  unit Test.HexToBin;


interface

  uses
    Deltics.Smoketest;


  type
    THexToBinTests = class(TTest)
      procedure HexToBinFromStringDecodesLowercaseCorrectly;
      procedure HexToBinFromAnsiStringDecodesLowercaseCorrectly;
      procedure HexToBinFromWideStringDecodesLowercaseCorrectly;
      procedure HexToBinFromStringDecodesUppercaseCorrectly;
      procedure HexToBinFromAnsiStringDecodesUppercaseCorrectly;
      procedure HexToBinFromWideStringDecodesUppercaseCorrectly;
      procedure HexToBinThrowsExceptionIfStringContainsNonHexadecimalCharacters;
    end;



implementation

  uses
    Deltics.Exceptions,
    Deltics.Hex2Bin;


{ TBin2HexTests ---------------------------------------------------------------------------------- }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure THexToBinTests.HexToBinFromStringDecodesLowercaseCorrectly;
  const
    STR: String = '0a0b0c0dfeff1234';
  var
    expectedBuf: Int64;
    buf: Int64;
  begin
    expectedBuf := $0a0b0c0dfeff1234;

    HexToBin(STR, @buf);

    Test('HexToBin(''0a0b0c0dfeff1234'')').Assert(buf).Equals(expectedBuf);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure THexToBinTests.HexToBinFromAnsiStringDecodesLowercaseCorrectly;
  const
    STR: AnsiString = '0a0b0c0dfeff1234';
  var
    expectedBuf: Int64;
    buf: Int64;
  begin
    expectedBuf := $0a0b0c0dfeff1234;

    HexToBin(STR, @buf);

    Test('HexToBin(ANSI''0a0b0c0dfeff1234'')').Assert(buf).Equals(expectedBuf);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure THexToBinTests.HexToBinFromWideStringDecodesLowercaseCorrectly;
  const
    STR: WideString = '0a0b0c0dfeff1234';
  var
    expectedBuf: Int64;
    buf: Int64;
  begin
    expectedBuf := $0a0b0c0dfeff1234;

    HexToBin(STR, @buf);

    Test('HexToBin(WIDE''0a0b0c0dfeff1234'')').Assert(buf).Equals(expectedBuf);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure THexToBinTests.HexToBinFromStringDecodesUppercaseCorrectly;
  const
    STR: String = '0A0B0C0DFEFF1234';
  var
    expectedBuf: Int64;
    buf: Int64;
  begin
    expectedBuf := $0a0b0c0dfeff1234;

    HexToBin(STR, @buf);

    Test('HexToBin(''0a0b0c0dfeff1234'')').Assert(buf).Equals(expectedBuf);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure THexToBinTests.HexToBinFromAnsiStringDecodesUppercaseCorrectly;
  const
    STR: AnsiString = '0A0B0C0DFEFF1234';
  var
    expectedBuf: Int64;
    buf: Int64;
  begin
    expectedBuf := $0a0b0c0dfeff1234;

    HexToBin(STR, @buf);

    Test('HexToBin(ANSI''0a0b0c0dfeff1234'')').Assert(buf).Equals(expectedBuf);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure THexToBinTests.HexToBinFromWideStringDecodesUppercaseCorrectly;
  const
    STR: WideString = '0A0B0C0DFEFF1234';
  var
    expectedBuf: Int64;
    buf: Int64;
  begin
    expectedBuf := $0a0b0c0dfeff1234;

    HexToBin(STR, @buf);

    Test('HexToBin(WIDE''0a0b0c0dfeff1234'')').Assert(buf).Equals(expectedBuf);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure THexToBinTests.HexToBinThrowsExceptionIfStringContainsNonHexadecimalCharacters;
  var
    buf: Byte;
  begin
    Test.Raises(EArgumentException);

    HexToBin('0G', @buf);
  end;




end.

