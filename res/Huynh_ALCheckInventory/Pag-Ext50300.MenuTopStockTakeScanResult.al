pageextension 70005 ExtMenuTopStockTakeScanResult extends "Order Processor Role Center"
{
    actions
    {
        addafter(Locations)
        {
            action(StackTakeScanResult)
            {
                ApplicationArea = ALL;
                CaptionML = ENU = 'Stack Take Scan Result';
                RunObject = page PageStockTakeScanResultt;
            }
        }
    }
}
