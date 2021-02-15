
{$i deltics.hex.inc}

  unit Test.BinToHex;


interface

  uses
    Deltics.Smoketest;


  type
    TBinToHexTests = class(TTest)
      procedure BinToHexReturningStringEncodesAsHexCorrectly;
      procedure BinToHexYieldingWideStringEncodesAsHexCorrectly;
      procedure BinToHexYieldingAnsiStringEncodesAsHexCorrectly;
      procedure BinToHexOfIntegerReturningStringEncodesAsHexCorrectly;
      procedure BinToHexOfIntegerYieldingWideStringEncodesAsHexCorrectly;
      procedure BinToHexOfIntegerYieldingAnsiStringEncodesAsHexCorrectly;
    end;



implementation

  uses
    Deltics.Hex;


{ TBin2HexTests ---------------------------------------------------------------------------------- }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TBinToHexTests.BinToHexReturningStringEncodesAsHexCorrectly;
  var
    buf: Int64;
    s: String;
  begin
    buf := $0a0b0c0dfeff1234;
    s   := BinToHex(@buf, sizeof(BUF));

    Test('BinToHex(@$0a0b0c0dfeff1234)').Assert(s).Equals('0a0b0c0dfeff1234');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TBinToHexTests.BinToHexYieldingAnsiStringEncodesAsHexCorrectly;
  var
    buf: Int64;
    s: AnsiString;
  begin
    buf := $0a0b0c0dfeff1234;
    BinToHex(@buf, sizeof(BUF), s);

    Test('BinToHex(@$0a0b0c0dfeff1234, var ansistring)').Assert(s).Equals('0a0b0c0dfeff1234');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TBinToHexTests.BinToHexYieldingWideStringEncodesAsHexCorrectly;
  var
    buf: Int64;
    s: WideString;
  begin
    buf := $0a0b0c0dfeff1234;
    BinToHex(@buf, sizeof(BUF), s);

    Test('BinToHex(@$0a0b0c0dfeff1234, var widestring)').Assert(s).Equals('0a0b0c0dfeff1234');
  end;






  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TBinToHexTests.BinToHexOfIntegerReturningStringEncodesAsHexCorrectly;
  begin
    Test('BinToHex(0x1234abcd)').Assert(BinToHex($1234abcd)).Equals('1234abcd');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TBinToHexTests.BinToHexOfIntegerYieldingAnsiStringEncodesAsHexCorrectly;
  var
    s: AnsiString;
  begin
    BinToHex($1234abcd, s);

    Test('BinToHex(0x1234abcd, var ansistring)').Assert(s).Equals('1234abcd');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TBinToHexTests.BinToHexOfIntegerYieldingWideStringEncodesAsHexCorrectly;
  var
    s: WideString;
  begin
    BinToHex($1234abcd, s);

    Test('BinToHex(0x1234abcd, var widestring)').Assert(s).Equals('1234abcd');
  end;







end.
