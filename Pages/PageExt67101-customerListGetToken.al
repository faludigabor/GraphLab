pageextension 67101 customerListGetToken extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Customer")
        {
            action(GetToken)
            {
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    TokenMgt: Codeunit TokenMgt;
                    tokenobj: text;
                begin
                    tokenobj := TokenMgt.GetOauthToken();
                    TokenMgt.createBCEnviroment(tokenobj, 'demo');
                end;
            }
        }

    }

    var
        myInt: Integer;
}