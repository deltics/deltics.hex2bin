
{$i deltics.inc}

  unit Test.BinToHex;


interface

  uses
    Deltics.Smoketest;


  type
    TBinToHexTests = class(TTest)
      procedure BinToHexReturningStringEncodesAsHexCorrectly;
      procedure BinToHexYieldingWideStringEncodesAsHexCorrectly;
      procedure BinToHexYieldingAnsiStringEncodesAsHexCorrectly;
    end;



implementation

  uses
    Deltics.Hex2Bin;


{ TBin2HexTests ---------------------------------------------------------------------------------- }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TBinToHexTests.BinToHexReturningStringEncodesAsHexCorrectly;
  var
    buf: Int64;
    s: String;
  begin
    buf := $0a0b0c0dfeff1234;
    s   := BinToHex(@buf, sizeof(buf));

    Test('BinToHex(@$0a0b0c0dfeff1234)').Assert(s).Equals('0a0b0c0dfeff1234');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TBinToHexTests.BinToHexYieldingAnsiStringEncodesAsHexCorrectly;
  var
    buf: Int64;
    s: AnsiString;
  begin
    buf := $0a0b0c0dfeff1234;
    BinToHex(@buf, sizeof(buf), s);

    Test('BinToHex(@$0a0b0c0dfeff1234, var ansistring)').Assert(s).Equals('0a0b0c0dfeff1234');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TBinToHexTests.BinToHexYieldingWideStringEncodesAsHexCorrectly;
  var
    buf: Int64;
    s: WideString;
  begin
    buf := $0a0b0c0dfeff1234;
    BinToHex(@buf, sizeof(buf), s);

    Test('BinToHex(@$0a0b0c0dfeff1234, var widestring)').Assert(s).Equals('0a0b0c0dfeff1234');
  end;






end.
