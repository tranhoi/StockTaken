page 50202 StockTakeScanResultCard
{
    ApplicationArea = All;
    Caption = 'StockTakeScanResultCard';
    PageType = Card;
    SourceTable = StockTakeScanResult;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(Barcode; Rec.Barcode)
                {
                    ToolTip = 'Specifies the value of the Barcode field.';
                }
                field(ExpDate; Rec.ExpDate)
                {
                    ToolTip = 'Specifies the value of the ExpDate field.';
                }
                field(InsertDate; Rec.InsertDate)
                {
                    ToolTip = 'Specifies the value of the InsertDate field.';
                }
                field(LLMSCode; Rec.LLMSCode)
                {
                    ToolTip = 'Specifies the value of the LLMSCode field.';
                }
                field(LotNo; Rec.LotNo)
                {
                    ToolTip = 'Specifies the value of the LotNo field.';
                }
                field(Message; Rec.Message)
                {
                    ToolTip = 'Specifies the value of the Message field.';
                }
                field(NewLotNo; Rec.NewLotNo)
                {
                    ToolTip = 'Specifies the value of the NewLotNo field.';
                }
                field(ScanQty; Rec.ScanQty)
                {
                    ToolTip = 'Specifies the value of the ScanQty field.';
                }
                field(StockTakeDate; Rec.StockTakeDate)
                {
                    ToolTip = 'Specifies the value of the StockTakeDate field.';
                }
                field(Warehouse; Rec.Warehouse)
                {
                    ToolTip = 'Specifies the value of the Warehouse field.';
                }
            }
        }
    }
}
