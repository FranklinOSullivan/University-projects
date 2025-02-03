use std.textio.all;

package test_utils is
    procedure print(msg : string);
    procedure test(assertion : boolean; msg : string; unit : string);
end package test_utils;

package body test_utils is
    procedure print(msg : string) is
        variable l          : line;
    begin
        write(l, msg);
        writeline(output, l);
    end;

    procedure test(assertion : boolean; msg : string; unit : string) is
    begin
        assert assertion
        report unit & " - " & msg
            severity failure;
    end;

end package body test_utils;