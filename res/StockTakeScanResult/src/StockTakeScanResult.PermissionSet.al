permissionset 50200 StockTakeScanResult
{
    Assignable = true;
    Caption = 'StockTakeScanResult', MaxLength = 30;
    Permissions =
        table StockTakeScanResult = X,
        tabledata StockTakeScanResult = RMID;
}
