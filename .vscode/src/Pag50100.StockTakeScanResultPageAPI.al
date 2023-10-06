page 50100 StockTakeScanResultPageAPI
{
    APIGroup = 'inventory';
    APIPublisher = 'shuei';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'stockTakeScanResultPageAPI';
    DelayedInsert = true;
    EntityName = 'stocktakescanresult';
    EntitySetName = 'stocktakescanresults';
    PageType = API;
    SourceTable = StockTakeScanResult;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(barcode; Rec.Barcode)
                {
                    Caption = 'Barcode';
                }
                field(expDate; Rec.ExpDate)
                {
                    Caption = 'ExpDate';
                }
                field(insertDate; Rec.InsertDate)
                {
                    Caption = 'InsertDate';
                }
                field(llmsCode; Rec.LLMSCode)
                {
                    Caption = 'LLMSCode';
                }
                field(lotNo; Rec.LotNo)
                {
                    Caption = 'LotNo';
                }
                field(message; Rec.Message)
                {
                    Caption = 'Message';
                }
                field(newLotNo; Rec.NewLotNo)
                {
                    Caption = 'NewLotNo';
                }
                field(scanQty; Rec.ScanQty)
                {
                    Caption = 'ScanQty';
                }
                field(seq; Rec.Seq)
                {
                    Caption = 'Seq';
                }
                field(stockTakeDate; Rec.StockTakeDate)
                {
                    Caption = 'StockTakeDate';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(warehouse; Rec.Warehouse)
                {
                    Caption = 'Warehouse';
                }
            }
        }
    }
}
