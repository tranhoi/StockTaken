page 50301 PageStockTakeScanResult
{
    ApplicationArea = All;
    Caption = 'Stock Take Scan Result';
    PageType = List;
    SourceTable = TableStockTakeScanResult;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Seq; Rec.Seq)
                {
                    ApplicationArea = ALL;
                }
                field(StockTakeDate; Rec.StockTakeDate)
                {
                    ApplicationArea = ALL;
                }
                field(LLMSCode; Rec.LLMSCode)
                {
                    ApplicationArea = ALL;
                }
                field(BarCode; Rec.BarCode)
                {
                    ApplicationArea = ALL;
                }
                field(LotNo; Rec.LotNo)
                {
                    ApplicationArea = ALL;
                }
                field(NewLotNo; Rec.NewLotNo)
                {
                    ApplicationArea = ALL;
                }
                field(ExpDate; Rec.ExpDate)
                {
                    ApplicationArea = ALL;
                }
                field(ScanQty; Rec.ScanQty)
                {
                    ApplicationArea = ALL;
                }
                field(WareHouse; Rec.WareHouse)
                {
                    ApplicationArea = ALL;
                }
                field(Message; Rec.Message)
                {
                    ApplicationArea = ALL;
                }
                field(InsertDate; Rec.InsertDate)
                {
                    ApplicationArea = ALL;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(CheckAPI)
            {
                ApplicationArea = All;
                Caption = 'Check API';
                Image = Approval;
                ShortCutKey = 'F7';
                ToolTip = 'Check api have active';

                trigger OnAction()
                var
                    varCheckAPI: Codeunit CodunitCheckAPI;
                    JsonObj: JsonObject;
                    JsonArr: JsonArray;
                    JsonString: Text;
                    JsonTokenVar: JsonToken;
                    Element: JsonToken;
                    Id: Integer;
                    JsonPara: Text;
                    Index: Integer;
                    JsonValue: JsonToken;
                    Value1: Text;
                    Value2: Text;
                    DataScanResult: Record TableStockTakeScanResult;
                begin
                    JsonPara := '{"LLMSCODE": "AC001-1418510100", "Barcode": "0630175507648", "LotNo":"N1220400202505", "NewLotNo": "", "Expdate": "2025/05", "ScanQty":"20", "WareHouse": "SG"}';
                    JsonString := varCheckAPI.PostRequest(JsonPara);
                    if not jsonObj.ReadFrom(JsonString) then
                        Error(InvalidResponseError);
                    JsonTokenVar.ReadFrom(JsonString);
                    if JsonTokenVar.IsObject and JsonObj.Get('RESDATA', JsonTokenVar) then begin
                        // JsonObj := JsonTokenVar.AsObject();
                        JsonArr := JsonTokenVar.AsArray();
                        if DataScanResult.FindLast() then begin
                            // Bây giờ, MyRecord chứa dữ liệu của dòng cuối cùng trong bảng
                            // Bạn có thể làm việc với dữ liệu này ở đây
                            Id := Rec.Seq + 1;
                        end;

                        // foreach Element in JsonObj.Values DO begin
                        //     Id := Id + 1;
                        //     JsonPara := GetJsonObjectValueFromToken('ISERROR', Element).AsText();
                        //     //InsertRec(GetJsonObjectValueFromToken('code', Element).AsText(), GetJsonObjectValueFromToken('value', Element).AsText(), Id);
                        // end;
                        for Index := 0 to (JsonArr.Count() - 1) DO begin
                            Id := Id + 1;
                            JsonArr.Get(Index, JsonValue);
                            Value1 := GetJsonObjectValueFromToken('ISERROR', JsonValue).AsText();
                            Value2 := GetJsonObjectValueFromToken('MESSAGES', JsonValue).AsText();
                            //InsertRec(Value1, Value2, Id);
                        end;
                    end;
                end;
            }
            action(CheckStokeTake)
            {
                ApplicationArea = ALL;
                CaptionML = ENU = 'Check Stoke Take';
                RunObject = page PageCheckStokeTake;
            }
        }

    }
    local procedure GetJsonObjectValueFromToken(Parameter: Text; JsonTokenVar: JsonToken): JsonValue;
    begin
        //Getting values of the parameters in the JSON object..
        JsonTokenVar.AsObject().Get(Parameter, JsonTokenVar);
        exit(JsonTokenVar.AsValue());
    end;

    local procedure ClearRec()
    begin
        Rec.Reset();
        Rec.DeleteAll();
    end;

    local procedure InsertRec(LLMSCode: Text[30]; Message: Text; Id: Integer)
    var
        split: List of [Text];
    begin
        //Inserting currency data to the Rec.
        split := Message.Split('/');
        Rec.Seq := Id;
        Rec.LLMSCode := split.get(1).Replace('LLMSCode=', '');
        Rec.LotNo := split.Get(2).Replace('LotNo=', '');
        Rec.Message := split.Get(4).Replace('Error=', '');
        Rec.InsertDate := CurrentDateTime();
        Rec.ExpDate := split.Get(3).Replace('ExpDate=', '');
        Rec.Insert();
    end;

    var
        RequestFailError: Label 'Unable to process the request through the API!';
        InvalidResponseError: Label 'Invalid response!';
}
