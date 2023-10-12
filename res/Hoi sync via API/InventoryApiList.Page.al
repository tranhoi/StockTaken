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
            action("Post data")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    LLMSRecord: Record LLMS;
                    JSonRoot: JsonObject;
                    JSonItem: JsonObject;
                    JsonAr: JsonArray;
                    JsonDt: Text;
                    HttpCt: HttpContent;
                    HttpHd: HttpHeaders;
                    HttpCl: HttpClient;
                    HttpRM: HttpResponseMessage;
                    URL: Label 'https://192.168.99.4/manage/api/api_bc365_stocktake.cfm';
                    Response: Text;
                    apiconnector: DotNet apiconnector;
                    Base64: Codeunit "Base64 Convert";
                begin

                    CurrPage.GetRecord(LLMSRecord);
                    CurrPage.SetSelectionFilter(LLMSRecord);
                    if LLMSRecord.FindSet() then
                        repeat
                            Clear(JSonItem);
                            JSonItem.Add('NEWLOTNO', LLMSRecord.NewLotNo);
                            JSonItem.Add('EXPDATE', LLMSRecord.EpxDate);
                            JSonItem.Add('WAREHOUSE', LLMSRecord.Warehouse);
                            JSonItem.Add('LOTNO', LLMSRecord.LotNo);
                            JSonItem.Add('BARCODE', LLMSRecord.Barcode);
                            JSonItem.Add('LLMSCODE', LLMSRecord.LLMSCode);
                            JSonItem.Add('SCANQTY', LLMSRecord.ScanQty);
                            JsonAr.Add(JSonItem);
                        until LLMSRecord.Next() = 0;

                    JSonRoot.Add('REQDATA', JsonAr);
                    JSonRoot.WriteTo(JsonDt);
                    Message(apiconnector.postData(URL, JsonDt));
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
                    JSonRoot: JsonObject;
                    JsonDt: Text;
                begin
                    JSonRoot := ConvertToJson(Rec.ID);
                    JSonRoot.WriteTo(JsonDt);
                    Message(apiconnector.postData(URL, JsonDt));
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
        JsonOb.Add('REQDATA', TasksToJson(LLMSRecord.LLMSCode));
        exit(JsonOb);
    end;

    local procedure TasksToJson(LLMSCode__: Text): JsonArray
    var
        LLMSRecord: Record LLMS;
        JsonAr: JsonArray;
        Tools: Codeunit "Sea Json Tools";
    begin
        LLMSRecord.SetRange(LLMSCode, LLMSCode__);
        if LLMSRecord.FindSet() then
            repeat
                JsonAr.Add(Tools.Rec2Json(LLMSRecord));
            until LLMSRecord.Next() = 0;
        exit(JsonAr);
    end;
}