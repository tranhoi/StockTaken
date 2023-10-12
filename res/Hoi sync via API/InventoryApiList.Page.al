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
                    JsonIt: JsonObject;
                begin
                    CurrPage.GetRecord(LLMSRecord);
                    if LLMSRecord.FindSet() then
                        repeat
                            Clear(JsonIt);
                            JsonIt.Add('NEWLOTNO', LLMSRecord.NewLotNo);
                            JsonIt.Add('EXPDATE', LLMSRecord.ExpDate);
                            JsonIt.Add('WAREHOUSE', LLMSRecord.Warehouse);
                            JsonIt.Add('LOTNO', LLMSRecord.LotNo);
                            JsonIt.Add('BARCODE', LLMSRecord.Barcode);
                            JsonIt.Add('LLMSCODE', LLMSRecord.LLMSCode);
                            JsonIt.Add('SCANQTY', LLMSRecord.ScanQty);
                            JsonAr.Add(JsonIt);
                        //Perform your action
                        until LLMSRecord.Next() = 0;
                    JsonOb.Add('REQDATA', JsonAr);
                    JsonOb.WriteTo(JsonDt);
                    Message('%1', JsonDt);
                    Message(apiconnector.postData(URL, JsonDt));
                end;
            }
        }
    }
}