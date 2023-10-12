page 60031 "Stock Take Scan Result List"
{
    PageType = List;
    SourceTable = "Stock Take Scan Resultt";
    ApplicationArea = All;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Seq"; Rec."Seq")
                {
                    ApplicationArea = All;
                }
                field("StockTakeDate"; Rec."StockTakeDate")
                {
                    ApplicationArea = All;
                }
                field("LLMSCode"; Rec."LLMSCode")
                {
                    ApplicationArea = All;
                }
                field("Barcode"; Rec."Barcode")
                {
                    ApplicationArea = All;
                }
                field("LotNo"; Rec."LotNo")
                {
                    ApplicationArea = All;
                }
                field("NewLotNo"; Rec."NewLotNo")
                {
                    ApplicationArea = All;
                }
                field("ExpDate"; Rec."ExpDate")
                {
                    ApplicationArea = All;
                }
                field("ScanQty"; Rec."ScanQty")
                {
                    ApplicationArea = All;
                }
                field("Warehouse"; Rec."Warehouse")
                {
                    ApplicationArea = All;
                }
                field("Message"; Rec."Message")
                {
                    ApplicationArea = All;
                }
                field("InsertDate"; Rec."InsertDate")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    actions
    {
        area(processing)
        {
            action("Call Stock Take API")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    ApiResponseDetailsRec: Record "API Response Detailss";
                    ApiCallHistoryRec: Record "API Call Historyy";
                begin
                    PostData(ApiResponseDetailsRec, ApiCallHistoryRec);
                    CurrPage.Update();
                end;
            }

            action("View History")
            {
                ApplicationArea = All;
                Promoted = true;

                trigger OnAction();
                var
                    APICallHistoryPage: Page "API Call Historyy";
                begin
                    APICallHistoryPage.Run();
                end;
            }
        }
    }

    local procedure OpenAPIResponseDetailsPage(ParentCode: Code[50])
    var
        // ResponseDetailsPage: Page "API Response Details";
        ResponseDetailsRecord: Record "API Response Detailss";
    begin
        ResponseDetailsRecord.SetFilter("ParentCode", ParentCode);
        Page.RunModal(60011, ResponseDetailsRecord);
    end;

    procedure PostData(var ApiResponseDetailsRec: Record "API Response Detailss"; var ApiCallHistoryRec: Record "API Call Historyy")
    var
        Client: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;

        JsonContent: HttpContent;
        JsonObj: JsonObject;
        ResponseTxt: Text;
        ResDataToken: JsonToken;
        ResData: JsonArray;
        ResObjToken: JsonToken;
        ResObj: JsonObject;
        IsErrorToken: JsonToken;
        IsError: Integer;
        MessagesToken: JsonToken;
        Messages: Text;
        CurrentTime: Text;

        TodayDate: Text[8];
        StockTakeRec: Record "Stock Take Scan Resultt";
        ExcludeFields: List of [Text];
        ReqData: JsonArray;
        ReqDataTxt: Text;
        StockTakeScanJsonObj: JsonObject;

        JU: Codeunit "Json Utilss";
    begin
        TodayDate := DelChr(Format(Today(), 0, 9), '=', '-'); // yyyyMMdd
        CurrentTime := Format(CurrentDateTime, 0, 9); // yyyy-MM-ddThh:mm:ss.SSSZ

        StockTakeRec.SetFilter("StockTakeDate", TodayDate);

        ExcludeFields.Add('Seq');
        ExcludeFields.Add('StockTakeDate');
        ExcludeFields.Add('Message');
        ExcludeFields.Add('InsertDate');

        if StockTakeRec.FindSet() then begin
            repeat
                // StockTakeScanJsonObj := JU.Rec2Json(StockTakeRec);
                StockTakeScanJsonObj := JU.Rec2JsonV2(StockTakeRec, ExcludeFields);
                ReqData.Add(StockTakeScanJsonObj);
            until StockTakeRec.Next() = 0
        end;

        RequestMessage.Method := 'POST';
        RequestMessage.SetRequestUri('https://mock.apidog.com/m1/392948-0-default/manage/api/api_bc365_stocktake.cfm');
        // RequestMessage.SetRequestUri('https://192.168.99.4/manage/api/api_bc365_stoketake.cfm');

        // Create JSON payload
        ReqDataTxt := JU.JsonArrayToString(ReqData);
        JsonContent.WriteFrom(ReqDataTxt);
        RequestMessage.Content := JsonContent;

        if Client.Send(RequestMessage, ResponseMessage) then
            if ResponseMessage.IsSuccessStatusCode() then begin
                ResponseMessage.Content().ReadAs(ResponseTxt);
                JsonObj.ReadFrom(ResponseTxt);

                Message(ResponseTxt);

                // Insert into API Call History
                ApiCallHistoryRec.Init();
                ApiCallHistoryRec.Code := CreateGuid();
                ApiCallHistoryRec.Time := CurrentTime;
                ApiCallHistoryRec.Request := ReqDataTxt;
                ApiCallHistoryRec.Response := ResponseTxt;
                ApiCallHistoryRec.Insert();

                if JsonObj.Get('RESDATA', ResDataToken) then begin
                    ResData := ResDataToken.AsArray();
                    foreach ResObjToken in ResData do begin
                        ResObj := ResObjToken.AsObject();
                        if ResObj.Get('ISERROR', IsErrorToken) then
                            IsError := IsErrorToken.AsValue().AsInteger();
                        if ResObj.Get('MESSAGES', MessagesToken) then
                            Messages := MessagesToken.AsValue().AsText();

                        // Insert into API Response Details
                        ApiResponseDetailsRec.Init();
                        ApiResponseDetailsRec.PKCode := CreateGuid();
                        ApiResponseDetailsRec.IsError := IsError;
                        ApiResponseDetailsRec.Messages := Messages;
                        ApiResponseDetailsRec.Time := CurrentTime;
                        ApiResponseDetailsRec.ParentCode := ApiCallHistoryRec.Code;
                        ApiResponseDetailsRec.Insert();
                    end;
                end;
            end;
    end;

    // local procedure Rec2Json(Rec: Variant): JsonObject
    // var
    //     RecRef: RecordRef;
    //     FRef: FieldRef;
    //     ReturnJsonObj: JsonObject;
    //     i: Integer;
    // begin
    //     if Rec.IsRecord then begin
    //         RecRef.GetTable(Rec);
    //         for i := 1 to RecRef.FieldCount() do begin
    //             FRef := RecRef.FieldIndex(i);
    //             case FRef.Class of
    //                 FRef.Class::Normal:
    //                     ReturnJsonObj.Add(GetJsonFieldName(FRef), FieldRef2JsonValue((FRef)));
    //                 FRef.Class::FlowField:
    //                     begin
    //                         FRef.CalcField();
    //                         ReturnJsonObj.Add(GetJsonFieldName(FRef), FieldRef2JsonValue((FRef)));
    //                     end;
    //             end;
    //         end;
    //     end;

    //     exit(ReturnJsonObj);
    // end;

    // local procedure Rec2JsonV2(Rec: Variant; ExcludeFieldNames: List of [Text]): JsonObject
    // var
    //     RecRef: RecordRef;
    //     FRef: FieldRef;
    //     ReturnJsonObj: JsonObject;
    //     i: Integer;
    //     FieldName: Text;
    // begin
    //     if Rec.IsRecord then begin
    //         RecRef.GetTable(Rec);
    //         for i := 1 to RecRef.FieldCount() do begin
    //             FRef := RecRef.FieldIndex(i);
    //             FieldName := GetJsonFieldName(FRef);

    //             // Check if the field name is in the exclusion list
    //             if not ExcludeFieldNames.Contains(FieldName) then begin
    //                 case FRef.Class of
    //                     FRef.Class::Normal:
    //                         ReturnJsonObj.Add(FieldName, FieldRef2JsonValue((FRef)));
    //                     FRef.Class::FlowField:
    //                         begin
    //                             FRef.CalcField();
    //                             ReturnJsonObj.Add(FieldName, FieldRef2JsonValue((FRef)));
    //                         end;
    //                 end;
    //             end;
    //         end;
    //     end;

    //     exit(ReturnJsonObj);
    // end;

    // local procedure FieldRef2JsonValue(FRef: FieldRef): JsonValue
    // var
    //     V: JsonValue;
    //     D: Date;
    //     DT: DateTime;
    //     T: Time;
    //     B: Boolean;
    // begin
    //     case FRef.Type() of
    //         FieldType::Date:
    //             begin
    //                 D := FRef.Value;
    //                 V.SetValue(D);
    //             end;
    //         FieldType::Time:
    //             begin
    //                 T := FRef.Value;
    //                 V.SetValue(T);
    //             end;
    //         FieldType::DateTime:
    //             begin
    //                 DT := FRef.Value;
    //                 V.SetValue(DT);
    //             end;
    //         fieldType::Boolean:
    //             begin
    //                 B := FRef.Value;
    //                 V.SetValue(B);
    //             end;
    //         else
    //             V.SetValue(Format(FRef.Value, 0, 9));
    //     end;
    //     exit(v);
    // end;

    // local procedure GetJsonFieldName(FRef: FieldRef): Text
    // var
    //     Name: Text;
    //     i: Integer;
    // begin
    //     Name := FRef.Name();
    //     for i := 1 to Strlen(Name) do begin
    //         if Name[i] < '0' then
    //             Name[i] := '_';
    //     end;
    //     exit(Name.Replace('__', '_').TrimEnd('_').TrimStart('_'));
    // end;

    // local procedure JsonArrayToString(JsonArr: JsonArray): Text
    // var
    //     JsonStr: Text;
    //     JsonItem: JsonToken;
    //     JsonKey: Text;
    //     JsonValue: JsonToken;
    //     FirstItem: Boolean;
    // begin
    //     FirstItem := true;
    //     JsonStr := '[';

    //     foreach JsonItem in JsonArr do begin
    //         if not FirstItem then
    //             JsonStr += ',';

    //         if JsonItem.IsValue() then
    //             JsonStr += '"' + JsonItem.AsValue().AsText() + '"'
    //         else
    //             if JsonItem.IsObject() then
    //                 JsonStr += JsonObjectToString(JsonItem.AsObject())
    //             else
    //                 if JsonItem.IsArray() then
    //                     JsonStr += JsonArrayToString(JsonItem.AsArray())
    //                 else
    //                     JsonStr += '""';

    //         FirstItem := false;
    //     end;

    //     JsonStr += ']';
    //     exit(JsonStr);
    // end;

    // local procedure JsonObjectToString(JsonObj: JsonObject): Text
    // var
    //     JsonStr: Text;
    //     JsonKey: Text;
    //     JsonValue: JsonToken;
    //     FirstItem: Boolean;
    // begin
    //     FirstItem := true;
    //     JsonStr := '{';

    //     foreach JsonKey in JsonObj.Keys do begin
    //         if not FirstItem then
    //             JsonStr += ',';

    //         JsonStr += '"' + JsonKey + '":';

    //         JsonObj.Get(JsonKey, JsonValue);
    //         if JsonValue.IsValue() then
    //             JsonStr += '"' + JsonValue.AsValue().AsText() + '"'
    //         else
    //             if JsonValue.IsObject() then
    //                 JsonStr += JsonObjectToString(JsonValue.AsObject())
    //             else
    //                 if JsonValue.IsArray() then
    //                     JsonStr += JsonArrayToString(JsonValue.AsArray())
    //                 else
    //                     JsonStr += '""';

    //         FirstItem := false;
    //     end;

    //     JsonStr += '}';
    //     exit(JsonStr);
    // end;

}
