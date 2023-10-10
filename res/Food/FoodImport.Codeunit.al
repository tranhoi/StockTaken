codeunit 50103 FoodImport
{
    procedure GetData()
    var
        ApiLink: Text;
        Client: HttpClient;
        Response: HttpResponseMessage;
        JsonOb: JsonObject;
        JsonAr: JsonArray;
        JsonTk: JsonToken;
        ListKeys: List of [JsonToken];
        TextResponse: Text;
    begin
        ApiLink := 'https://api.sampleapis.com/beers/ale';
        if Client.Get(ApiLink, Response) then begin
            if Response.HttpStatusCode = 200 then begin
                Response.Content.ReadAs(TextResponse);
                Message(TextResponse);

                JsonOb.ReadFrom(TextResponse);
                ListKeys := JsonOb.Values;

                foreach JsonTk in ListKeys do begin
                    if JsonTk.IsValue then
                        Message(JsonTk.AsValue().AsText());

                    if JsonTk.IsArray then begin
                        JsonAr := JsonTk.AsArray();
                        foreach JsonTk in JsonAr do begin
                            if JsonTk.IsObject then
                                ProcessJsonOb(JsonTk)
                            else
                                Message(JsonTk.AsValue().AsText());
                        end;
                    end;
                end;
            end else
                Error('Call failed')
        end;
    end;

    local procedure ProcessJsonOb(JsonTks: JsonToken)
    var
        JsonOb2: JsonObject;
        JsonTk2: JsonToken;
        JsonKeys: Text;
        ObjectKeys: List of [Text];
        DataImport: Record "Food";
    begin
        JsonOb2 := JsonTks.AsObject();
        ObjectKeys := JsonOb2.Keys;
        foreach JsonKeys in ObjectKeys do begin
            JsonOb2.Get(JsonKeys, JsonTk2);
            if JsonTk2.IsValue then
                case JsonKeys of
                    'id':
                        begin
                            DataImport.Init();
                            DataImport.Insert();
                        end;
                    'name':
                        DataImport.Name := JsonTk2.AsValue().AsText();
                    'price':
                        DataImport.Price := JsonTk2.AsValue().AsText();
                end;
        end;
    end;
}