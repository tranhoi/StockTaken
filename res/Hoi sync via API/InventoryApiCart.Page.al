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
                    Message('%1', Format(ConvertToJson(Rec.ID)));
                end;
            }
        }
    }
    local procedure ConvertToJson(ID_: Integer): JsonObject
    var
        LLMSRecord: Record LLMS;
        JsonOb: JsonObject;
    begin
        LLMSRecord.Get(ID_);
        JsonOb.Add('REQDATA', TasksToJson(LLMSRecord.ID));
        exit(JsonOb);
    end;

    local procedure TasksToJson(ID__: Integer): JsonArray
    var
        LLMSRecord: Record LLMS;
        JsonAr: JsonArray;
        Tools: Codeunit "Sea Json Tools";
    begin
        LLMSRecord.SetRange(ID, ID__);
        if LLMSRecord.FindSet() then
            repeat
                JsonAr.Add(Tools.Rec2Json(LLMSRecord));
            until LLMSRecord.Next() = 0;
        exit(JsonAr);
    end;
}