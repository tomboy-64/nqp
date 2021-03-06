
# TODO think if we should be using such a complicated name mangling scheme
# It's separated into a role so we may replace it with an different scheme when we want to reduce the output size
role DWIMYNameMangling {
    my %mangle;
    %mangle<_> := 'UNDERSCORE';
    %mangle<&> := 'AMPERSAND';
    %mangle<:> := 'COLON';
    %mangle<;> := 'SEMI';
    %mangle<<> := 'LESS';
    %mangle<>> := 'MORE';
    %mangle<{> := 'CURLY_OPEN';
    %mangle<}> := 'CURLY_CLOSE';
    %mangle<[> := 'BRACKET_OPEN';
    %mangle<]> := 'BRACKET_CLOSE';
    %mangle<(> := 'PAREN_OPEN';
    %mangle<)> := 'PAREN_CLOSE';
    %mangle<~> := 'TILDE';
    %mangle<+> := 'PLUS';
    %mangle<=> := 'EQUAL';
    %mangle<?> := 'QUESTION';
    %mangle<!> := 'BANG';
    %mangle</> := 'SLASH';
    %mangle<*> := 'STAR';
    %mangle<-> := 'MINUS';
    %mangle<@> := 'AT';
    %mangle<,> := 'COMMA';
    %mangle<%> := 'PERCENT';
    %mangle<¢> := 'CENT';
    %mangle< > := 'SPACE';
    %mangle<'> := 'SINGLE';
    %mangle<"> := 'QUOTE';
    %mangle<^> := 'CARET';
    %mangle<.> := 'DOT';
    %mangle<|> := 'PIPE';
    %mangle<`> := 'BACKTICK';
    %mangle<$> := 'DOLLAR';
    %mangle<\\> := 'BACKSLASH';

    method mangle_name($name) {
        $name := 'p6$' ~ $name;

        my $mangled := '';

        for nqp::split('',$name) -> $char {
            if nqp::iscclass(nqp::const::CCLASS_ALPHANUMERIC, $char, 0) {
                $mangled := $mangled ~ $char;
            }
            else {
                if nqp::existskey(%mangle, $char) {
                    $mangled := $mangled ~ '_' ~ %mangle{$char} ~ '_';
                }
                else {
                    $mangled := $mangled ~ '_' ~ nqp::ord($char) ~ '_';
                }
            }
        }

        $mangled;
    }
}
