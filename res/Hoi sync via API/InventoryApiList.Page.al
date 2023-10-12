page 50111 InventoryApiList
{
    PageType = List;
    Caption = 'Sync data via API';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = LLMS;
    CardPageID = InventoryApiCart;

    layout
    {
        area(Content)
        {
            repeater(LLMS)
            {
                field(ID; rec.ID)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
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
                field(EpxDate; rec.ExpDate)
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
    }

    actions
    {
        area(Processing)
        {
            action("Get data")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    InvenApiImport: Codeunit InventoryApiImport;
                begin
                    InvenApiImport.GetData();
                end;
            }

            action("Post all data")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    apiconnector: DotNet apiconnector;
                    URL: Label 'https://192.168.99.4/manage/api/api_bc365_stocktake.cfm';
                    JsonDt: Text;

                    LLMSRecord: Record LLMS;
                    JsonOb: JsonObject;
                    JsonAr: JsonArray;

                    NewJsondDt: Text;
                begin
                    CurrPage.GetRecord(LLMSRecord);
                    if LLMSRecord.FindSet() then
                        repeat
                            JsonAr.Add(TasksToJson(LLMSRecord.ID));
                        until LLMSRecord.Next() = 0;
                    JsonOb.Add('REQDATA', JsonAr);
                    JsonOb.WriteTo(JsonDt);
                    NewJsondDt := DelChr(JsonDt, '<>', '[]');
                    Message('%1', NewJsondDt);
                    Message(apiconnector.postData(URL, JsonDt));
                end;
            }
        }
    }

    local procedure TasksToJson(ID_: Integer): JsonArray
    var
        LLMSRecord: Record LLMS;
        JsonAr: JsonArray;
        JsonOb: JsonObject;
        Tools: Codeunit "Sea Json Tools";
    begin
        LLMSRecord.SetRange(ID, ID_);
        if LLMSRecord.FindSet() then
            repeat
                JsonAr.Add(Tools.Rec2Json(LLMSRecord));
            until LLMSRecord.Next() = 0;
        exit(JsonAr);
    end;
}