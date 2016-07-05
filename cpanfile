requires 'perl','5.10.1';
requires 'Catmandu','1.0';
requires 'namespace::clean','0.24';
requires 'Poppler','1.0101';
requires 'Moo';

on 'test', sub {
    requires 'Test::Exception','0';
    requires 'Test::More','0';
};
