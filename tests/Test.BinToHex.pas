
{$i deltics.inc}

  unit Test.BinToHex;


interface

  uses
    Deltics.Smoketest;


  type
    TBinToHexTests = class(TTest)
      procedure BinToHexWithNoCaseSpecified;
      procedure BinToHexWithUpperCaseSpecified;
      procedure BinToHexAnsiVarParam;
      procedure BinToHexWideVarParam;
    end;



implementation

  uses
    Deltics.Hex2Bin;


{ TBin2HexTests ---------------------------------------------------------------------------------- }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TBinToHexTests.BinToHexWithNoCaseSpecified;
  var
    buf: Int64;
    s: String;
  begin
    buf := $0a0b0c0dfeff1234;
    s   := Hex2Bin.ToHex(@buf, sizeof(buf));

    Test('Hex2Bin.ToHex(@$0a0b0c0dfeff1234)').Assert(s).Equals('0a0b0c0dfeff1234');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TBinToHexTests.BinToHexWithUpperCaseSpecified;
  var
    buf: Int64;
    s: String;
  begin
    buf := $0a0b0c0dfeff1234;
    s   := Hex2Bin.ToHex(@buf, sizeof(buf), hexUppercase);

    Test('Hex2Bin.ToHex(@$0a0b0c0dfeff1234), hexUppercase').Assert(s).Equals('0A0B0C0DFEFF1234');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TBinToHexTests.BinToHexAnsiVarParam;
  var
    buf: Int64;
    s: AnsiString;
  begin
    buf := $0a0b0c0dfeff1234;
    Hex2Bin.ToHex(@buf, sizeof(buf), s);

    Test('Hex2Bin.ToHex(@$0a0b0c0dfeff1234, var ansistring)').Assert(s).Equals('0a0b0c0dfeff1234');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TBinToHexTests.BinToHexWideVarParam;
  var
    buf: Int64;
    s: WideString;
  begin
    buf := $0a0b0c0dfeff1234;
    Hex2Bin.ToHex(@buf, sizeof(buf), s);

    Test('Hex2Bin.ToHex(@$0a0b0c0dfeff1234, var widestring)').Assert(s).Equals('0a0b0c0dfeff1234');
  end;






end.
