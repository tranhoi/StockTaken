page 50200 StockTakeScanResultWS
{
    APIGroup = 'invent';
    APIPublisher = 'shuei';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'stockTakeScanResult';
    DelayedInsert = true;
    EntityName = 'stocksakescanresult';
    EntitySetName = 'stocktakescanresults';
    PageType = API;
    SourceTable = StockTakeScanResult;

    layout
    {
        area(content)
        {
            repeater(General)
            {
            }
        }
    }
}
