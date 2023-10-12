pageextension 50200 StockTakeScanResultNav extends "Order Processor Role Center"
{
    actions
    {
        addlast(Action62)
        {

            action("Stock take scan result")
            {

                RunObject = page "StockTakeScanResultList";
                ApplicationArea = All;
            }


        }

    }
}