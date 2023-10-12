codeunit 70002 "Json Utilss"
{

    procedure Rec2Json(Rec: Variant): JsonObject
    var
        RecRef: RecordRef;
        FRef: FieldRef;
        ReturnJsonObj: JsonObject;
        i: Integer;
    begin
        if Rec.IsRecord then begin
            RecRef.GetTable(Rec);
            for i := 1 to RecRef.FieldCount() do begin
                FRef := RecRef.FieldIndex(i);
                case FRef.Class of
                    FRef.Class::Normal:
                        ReturnJsonObj.Add(GetJsonFieldName(FRef), FieldRef2JsonValue((FRef)));
                    FRef.Class::FlowField:
                        begin
                            FRef.CalcField();
                            ReturnJsonObj.Add(GetJsonFieldName(FRef), FieldRef2JsonValue((FRef)));
                        end;
                end;
            end;
        end;

        exit(ReturnJsonObj);
    end;

    procedure Rec2JsonV2(Rec: Variant; ExcludeFieldNames: List of [Text]): JsonObject
    var
        RecRef: RecordRef;
        FRef: FieldRef;
        ReturnJsonObj: JsonObject;
        i: Integer;
        FieldName: Text;
    begin
        if Rec.IsRecord then begin
            RecRef.GetTable(Rec);
            for i := 1 to RecRef.FieldCount() do begin
                FRef := RecRef.FieldIndex(i);
                FieldName := GetJsonFieldName(FRef);

                // Check if the field name is in the exclusion list
                if not ExcludeFieldNames.Contains(FieldName) then begin
                    case FRef.Class of
                        FRef.Class::Normal:
                            ReturnJsonObj.Add(FieldName, FieldRef2JsonValue((FRef)));
                        FRef.Class::FlowField:
                            begin
                                FRef.CalcField();
                                ReturnJsonObj.Add(FieldName, FieldRef2JsonValue((FRef)));
                            end;
                    end;
                end;
            end;
        end;

        exit(ReturnJsonObj);
    end;

    procedure JsonArrayToString(JsonArr: JsonArray): Text
    var
        JsonStr: Text;
        JsonItem: JsonToken;
        JsonKey: Text;
        JsonValue: JsonToken;
        FirstItem: Boolean;
    begin
        FirstItem := true;
        JsonStr := '[';

        foreach JsonItem in JsonArr do begin
            if not FirstItem then
                JsonStr += ',';

            if JsonItem.IsValue() then
                JsonStr += '"' + JsonItem.AsValue().AsText() + '"'
            else
                if JsonItem.IsObject() then
                    JsonStr += JsonObjectToString(JsonItem.AsObject())
                else
                    if JsonItem.IsArray() then
                        JsonStr += JsonArrayToString(JsonItem.AsArray())
                    else
                        JsonStr += '""';

            FirstItem := false;
        end;

        JsonStr += ']';
        exit(JsonStr);
    end;

    procedure JsonObjectToString(JsonObj: JsonObject): Text
    var
        JsonStr: Text;
        JsonKey: Text;
        JsonValue: JsonToken;
        FirstItem: Boolean;
    begin
        FirstItem := true;
        JsonStr := '{';

        foreach JsonKey in JsonObj.Keys do begin
            if not FirstItem then
                JsonStr += ',';

            JsonStr += '"' + JsonKey + '":';

            JsonObj.Get(JsonKey, JsonValue);
            if JsonValue.IsValue() then
                JsonStr += '"' + JsonValue.AsValue().AsText() + '"'
            else
                if JsonValue.IsObject() then
                    JsonStr += JsonObjectToString(JsonValue.AsObject())
                else
                    if JsonValue.IsArray() then
                        JsonStr += JsonArrayToString(JsonValue.AsArray())
                    else
                        JsonStr += '""';

            FirstItem := false;
        end;

        JsonStr += '}';
        exit(JsonStr);
    end;

    local procedure FieldRef2JsonValue(FRef: FieldRef): JsonValue
    var
        V: JsonValue;
        D: Date;
        DT: DateTime;
        T: Time;
        B: Boolean;
    begin
        case FRef.Type() of
            FieldType::Date:
                begin
                    D := FRef.Value;
                    V.SetValue(D);
                end;
            FieldType::Time:
                begin
                    T := FRef.Value;
                    V.SetValue(T);
                end;
            FieldType::DateTime:
                begin
                    DT := FRef.Value;
                    V.SetValue(DT);
                end;
            fieldType::Boolean:
                begin
                    B := FRef.Value;
                    V.SetValue(B);
                end;
            else
                V.SetValue(Format(FRef.Value, 0, 9));
        end;
        exit(v);
    end;

    local procedure GetJsonFieldName(FRef: FieldRef): Text
    var
        Name: Text;
        i: Integer;
    begin
        Name := FRef.Name();
        for i := 1 to Strlen(Name) do begin
            if Name[i] < '0' then
                Name[i] := '_';
        end;
        exit(Name.Replace('__', '_').TrimEnd('_').TrimStart('_'));
    end;

}