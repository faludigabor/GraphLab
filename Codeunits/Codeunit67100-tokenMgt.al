codeunit 67100 "TokenMgt"
{
    trigger OnRun()
    begin

    end;

    procedure GetOauthToken(): Text
    var
        TokenURL: Label 'https://login.windows.net/xxxxxx.onmicrosoft.com/oauth2/token';
        ClientId: Label 'xxxxx';
        ClientSecret: Label 'xxxx';
        Resource: Label 'https://api.businesscentral.dynamics.com';
        RequestBody: Label 'grant_type=client_credentials&client_id=%1&client_secret=%2&resource=%3';
        HttpClient: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        RequestHeader: HttpHeaders;
        Content: HttpContent;
        TempBlob: Codeunit "Temp Blob";
        Outstr: OutStream;
        Instr: InStream;
        APIResult: Text;
    begin

        Content.GetHeaders(RequestHeader);
        RequestHeader.Clear();

        HttpClient.SetBaseAddress(TokenURL);
        RequestMessage.Method('POST');
        RequestHeader.Remove('Content-Type');
        RequestHeader.Add('Content-Type', 'application/x-www-form-urlencoded');

        Clear(TempBlob);
        TempBlob.CreateOutStream(Outstr);
        Outstr.WriteText(StrSubstNo(RequestBody, ClientId, ClientSecret, Resource));
        TempBlob.CreateInStream(Instr);

        Content.WriteFrom(Instr);
        RequestMessage.Content(Content);
        HttpClient.Send(RequestMessage, ResponseMessage);

        if ResponseMessage.IsSuccessStatusCode() then begin
            ResponseMessage.Content().ReadAs(APIResult);
            Message(APIResult);
        end;
        exit(APIResult);
    end;

    procedure createBCEnviroment(var tokenObj: text; envname: text)
    var
        httpClient: HttpClient;
        TokenJSON: JsonObject;
        jsonLeaf: JsonToken;
        httpResponse: HttpResponseMessage;
        httpContent: HttpContent;
    begin
        TokenJSON.ReadFrom(tokenObj);
        if (TokenJSON.Get('access_token', jsonLeaf)) then begin
            // Message(jsonLeaf.AsValue().AsText());

        end;
    end;
}

