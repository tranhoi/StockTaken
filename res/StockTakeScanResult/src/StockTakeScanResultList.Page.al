
page 50201 StockTakeScanResultList
{
    ApplicationArea = All;
    Caption = 'StockTakeScanResult';
    PageType = List;
    SourceTable = StockTakeScanResult;
    UsageCategory = Lists;
    CardPageId = StockTakeScanResultCard;
    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                field(Seq; Rec.Seq)
                {
                    ToolTip = 'Specifies the value of the Seq field.';
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
    actions
    {
        area(Processing)
        {
            action(UploadStockScan)
            {
                ApplicationArea = All;
                Caption = 'Upload to external service';
                ToolTip = 'Upload to external service';
                trigger OnAction();
                begin
                    callService();
                end;
            }
        }
    }
    local procedure callService()
    var
        StockTakeScanResult: Record StockTakeScanResult;
        JSonRoot: JsonObject;
        JSonItem: JsonObject;
        JsonArr: JsonArray;
        JsonData: Text;
        HttpContent: HttpContent;
        HttpHeader: HttpHeaders;
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        //URL: Label 'https://mock.apidog.com/m1/392948-0-default/manage/api/api_bc365_stocktake.cfm';
        URL: Label 'https://192.168.99.4/manage/api/api_bc365_stocktake.cfm';
        Response: Text;
        apiconnector: DotNet apiconnector;
        Base64: Codeunit "Base64 Convert";
    begin
        // Only get current record

        CurrPage.GetRecord(StockTakeScanResult);
        //Message('Current selected %1', stocktake.Barcode);
        CurrPage.SetSelectionFilter(StockTakeScanResult);
        // SETRANGE("Status Code",2); //Put your filter if required
        if StockTakeScanResult.FindSet() then
            repeat
                Clear(JSonItem);
                JSonItem.Add('NEWLOTNO', StockTakeScanResult.NewLotNo);
                JSonItem.Add('EXPDATE', StockTakeScanResult.ExpDate);
                JSonItem.Add('WAREHOUSE', StockTakeScanResult.Warehouse);
                JSonItem.Add('LOTNO', StockTakeScanResult.LotNo);
                JSonItem.Add('BARCODE', StockTakeScanResult.Barcode);
                JSonItem.Add('LLMSCODE', StockTakeScanResult.LLMSCode);
                JSonItem.Add('SCANQTY', StockTakeScanResult.ScanQty);
                JsonArr.Add(JSonItem);
            //Perform your action
            until StockTakeScanResult.Next() = 0;
        JSonRoot.Add('REQDATA', JsonArr);
        JSonRoot.WriteTo(JsonData);
        /*
        Message(JsonData);
        HttpContent.WriteFrom(JsonData);
        HttpContent.GetHeaders(HttpHeader);
        HttpHeader.Clear();
        HttpHeader.Add('Content-Type', 'application/json');

        if HttpClient.Post(URL, HttpContent, HttpResponseMessage) then begin
            Message('Test');
            HttpResponseMessage.Content.ReadAs(Response);
            Message(Response);
        end;
        */
        Message(apiconnector.postData('URL', JsonData));

    end;
}
