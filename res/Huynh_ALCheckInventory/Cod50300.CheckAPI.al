codeunit 70001 CodunitCheckAPIi
{
    procedure PostRequest(json: Text) ResponseText: Text
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseTextResult: Text;
        HttpStatusCode: Integer;
    begin
        Content.Clear();
        Content.GetHeaders(ContentHeaders);

        if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'multipart/form-data');

        Content.WriteFrom(json);

        IsSuccessful := Client.Post('https://mock.apidog.com/m1/392948-0-default/manage/api/api_bc365_stocktake.cfm', Content, Response);

        if not IsSuccessful then begin
            // handle the error
        end;

        if not Response.IsSuccessStatusCode() then begin
            HttpStatusCode := response.HttpStatusCode();
            // handle the error (depending on the HTTP status code)
        end;

        Response.Content().ReadAs(ResponseText);

    end;

    procedure GetCurrencyDataByAPI() JsonString: Text;
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
    begin
        //Sending the GET request through currency API and getting the response as JSON string..
        if not client.Get('https://api.currencyapi.com/v3/latest?apikey=GF9w85SLtC7UaTYA49hVKBzFwjdhTHdGdCqAKDkY', Response) then
            Error(RequestFailError);
        Response.Content().ReadAs(JsonString);
    end;

    var
        RequestFailError: Label 'Unable to process the request through the API!';
        InvalidResponseError: Label 'Invalid response!';
}
