page 50112 InventoryApiCart
{
    PageType = Card;
    Caption = 'Call inventory api';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = LLMS;

    layout
    {
        area(Content)
        {
            field(LLMSCode; rec.LLMSCode)
            {
                ApplicationArea = All;

            }
            field(BarCode; rec.BarCode)
            {
                ApplicationArea = All;

            }
            field(LotNo; rec.LotNo)
            {
                ApplicationArea = All;

            }
            field(NewLotNo; rec.NewLotNo)
            {
                ApplicationArea = All;

            }
            field(EpxDate; rec.EpxDate)
            {
                ApplicationArea = All;

            }
            field(ScanQty; rec.ScanQty)
            {
                ApplicationArea = All;

            }
            field(WareHouse; rec.WareHouse)
            {
                ApplicationArea = All;

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Call Api")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Message('%1', Format(ConvertToJson(Rec.LLMSCode)));
                end;
            }
        }
    }
    local procedure ConvertToJson(LLMSCode: Text): JsonObject
    var
        InvApi: Record LLMS;
        JsonOb: JsonObject;
    begin

    end;
}