
{$define CONSOLE}

{$i deltics.inc}

  program test;

uses
  Deltics.Smoketest,
  Deltics.Hex2Bin in '..\src\Deltics.Hex2Bin.pas',
  Test.BinToHex in 'Test.BinToHex.pas',
  Test.HexToBin in 'Test.HexToBin.pas';

begin
  TestRun.Test(TBinToHexTests);
  TestRun.Test(THexToBinTests);
end.
