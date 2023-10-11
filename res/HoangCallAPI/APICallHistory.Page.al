page 60001 "API Call History"
{
    PageType = List;
    SourceTable = "API Call History";
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    // DrillDownPage = "API Response Details";
                    trigger OnDrillDown()
                    begin
                        OpenAPIResponseDetailsPage(Rec.Code);
                    end;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                }
                field(Request; Rec.Request)
                {
                    ApplicationArea = All;
                }
                field(Response; Rec.Response)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    // actions
    // {
    //     area(processing)
    //     {
    //         action(CallAPI)
    //         {
    //             ApplicationArea = All;
    //             Promoted = true;
    //             PromotedIsBig = true;
    //             trigger OnAction();
    //             var
    //                 ApiResponseDetailsRec: Record "API Response Details";
    //                 ApiCallHistoryRec: Record "API Call History";
    //             begin
    //                 PostData(ApiResponseDetailsRec, ApiCallHistoryRec);
    //                 CurrPage.Update();
    //             end;
    //         }
    //     }
    // }

    local procedure OpenAPIResponseDetailsPage(ParentCode: Code[50])
    var
        // ResponseDetailsPage: Page "API Response Details";
        ResponseDetailsRecord: Record "API Response Details";
    begin
        ResponseDetailsRecord.SetFilter("ParentCode", ParentCode);
        Page.RunModal(60011, ResponseDetailsRecord);
    end;

    // procedure PostData(var ApiResponseDetailsRec: Record "API Response Details"; var ApiCallHistoryRec: Record "API Call History")
    // var
    //     Client: HttpClient;
    //     RequestMessage: HttpRequestMessage;
    //     ResponseMessage: HttpResponseMessage;
    //     JsonContent: HttpContent;
    //     JsonObj: JsonObject;
    //     ResponseTxt: Text;
    //     ResDataToken: JsonToken;
    //     ResData: JsonArray;
    //     ResObjToken: JsonToken;
    //     ResObj: JsonObject;
    //     IsErrorToken: JsonToken;
    //     IsError: Integer;
    //     MessagesToken: JsonToken;
    //     Messages: Text;
    //     CurrentTime: Text;
    // begin
    //     CurrentTime := Format(CurrentDateTime, 0, 9); // yyyy-MM-dd  hh:mm:ss
    //     RequestMessage.Method := 'POST';
    //     RequestMessage.SetRequestUri('https://mock.apidog.com/m1/392948-0-default/manage/api/api_bc365_stocktake.cfm');

    //     // Create JSON payload
    //     JsonContent.WriteFrom('{ "REQDATA": [ ... ] }'); // Replace '...' with your actual JSON payload
    //     RequestMessage.Content := JsonContent;

    //     if Client.Send(RequestMessage, ResponseMessage) then
    //         if ResponseMessage.IsSuccessStatusCode() then begin
    //             ResponseMessage.Content().ReadAs(ResponseTxt);
    //             JsonObj.ReadFrom(ResponseTxt);

    //             // Insert into API Call History
    //             ApiCallHistoryRec.Init();
    //             ApiCallHistoryRec.Code := CreateGuid();
    //             ApiCallHistoryRec.Time := CurrentTime;
    //             ApiCallHistoryRec.Response := ResponseTxt;
    //             ApiCallHistoryRec.Insert();

    //             if JsonObj.Get('RESDATA', ResDataToken) then begin
    //                 ResData := ResDataToken.AsArray();
    //                 foreach ResObjToken in ResData do begin
    //                     ResObj := ResObjToken.AsObject();
    //                     if ResObj.Get('ISERROR', IsErrorToken) then
    //                         IsError := IsErrorToken.AsValue().AsInteger();
    //                     if ResObj.Get('MESSAGES', MessagesToken) then
    //                         Messages := MessagesToken.AsValue().AsText();

    //                     // Insert into API Response Details
    //                     ApiResponseDetailsRec.Init();
    //                     ApiResponseDetailsRec.PKCode := CreateGuid();
    //                     ApiResponseDetailsRec.IsError := IsError;
    //                     ApiResponseDetailsRec.Messages := Messages;
    //                     ApiResponseDetailsRec.Time := CurrentTime;
    //                     ApiResponseDetailsRec.ParentCode := ApiCallHistoryRec.Code;
    //                     ApiResponseDetailsRec.Insert();
    //                 end;
    //             end;
    //         end;
    // end;
}
