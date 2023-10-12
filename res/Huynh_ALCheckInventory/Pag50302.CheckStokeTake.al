page 70004 PageCheckStokeTakee
{
    ApplicationArea = All;
    Caption = 'Check Stoke Take';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = TableStockTakeScanResultt;
    Editable = true;

    layout
    {
        area(content)
        {
            group(InputLinkAPI)
            {
                Caption = 'Link API';
                field(LinkAPI; LinkAPI)
                {
                    ApplicationArea = ALL;
                    Editable = true;
                }
            }
            group(InputParameter)
            {
                Caption = 'Parameter post';
                field(LLMSCode; LLMSCode)
                {
                    ApplicationArea = ALL;
                    Editable = true;
                }
                field(BarCode; BarCode)
                {
                    ApplicationArea = ALL;
                    Editable = true;
                }
                field(LotNo; LotNo)
                {
                    ApplicationArea = ALL;
                    Editable = true;
                }
                field(NewLotNo; NewLotNo)
                {
                    ApplicationArea = ALL;
                    Editable = true;
                }
                field(ExpDate; ExpDate)
                {
                    ApplicationArea = ALL;
                    Editable = true;
                }
                field(ScanQty; ScanQty)
                {
                    ApplicationArea = ALL;
                    Editable = true;
                }
                field(WareHouse; WareHouse)
                {
                    ApplicationArea = ALL;
                    Editable = true;
                }
            }
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
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    varCheckAPI: Codeunit CodunitCheckAPIi;
                    JsonObj: JsonObject;
                    JsonArr: JsonArray;
                    JsonString: Text;
                    JsonTokenVar: JsonToken;
                    Id: Integer;
                    JsonPara: Text;
                    Index: Integer;
                    JsonValue: JsonToken;
                    Value1: Text;
                    Value2: Text;
                    DataScanResult: Record TableStockTakeScanResultt;
                    Parapost: JsonObject;
                    ParaPostText: Text;
                    ReqData: JsonObject;
                begin
                    Parapost.Add('LLMSCODE', LLMSCode);
                    Parapost.Add('Barcode', BarCode);
                    Parapost.Add('LotNo', LotNo);
                    Parapost.Add('NewLotNo', NewLotNo);
                    Parapost.Add('Expdate', ExpDate);
                    Parapost.Add('ScanQty', ScanQty);
                    Parapost.Add('WareHouse', WareHouse);
                    ReqData.Add('REQDATA', Parapost);
                    ReqData.WriteTo(ParaPostText);
                    JsonString := varCheckAPI.PostRequest(ParaPostText);
                    if not jsonObj.ReadFrom(JsonString) then
                        Error(InvalidResponseError);
                    JsonTokenVar.ReadFrom(JsonString);
                    if JsonTokenVar.IsObject and JsonObj.Get('ResData', JsonTokenVar) then begin
                        // JsonObj := JsonTokenVar.AsObject();
                        JsonArr := JsonTokenVar.AsArray();
                        if DataScanResult.FindLast() then begin
                            // Bây giờ, MyRecord chứa dữ liệu của dòng cuối cùng trong bảng
                            // Bạn có thể làm việc với dữ liệu này ở đây
                            Id := Rec.Seq + 1;
                        end;
                        for Index := 0 to (JsonArr.Count() - 1) DO begin
                            Id := Id + 1;
                            JsonArr.Get(Index, JsonValue);
                            Value1 := GetJsonObjectValueFromToken('ISERROR', JsonValue).AsText();
                            Value2 := GetJsonObjectValueFromToken('MESSAGES', JsonValue).AsText();
                            InsertRec(Value1, Value2, Id);
                        end;
                    end;
                end;
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
        LLMSCode: Text[30];
        BarCode: Text[30];
        LotNo: Text[50];
        NewLotNo: Text[50];
        ScanQty: Integer;
        ExpDate: Text[7];
        WareHouse: Option "SG","HK";
        LinkAPI: Text[1000];
        RequestFailError: Label 'Unable to process the request through the API!';
        InvalidResponseError: Label 'Invalid response!';
}
