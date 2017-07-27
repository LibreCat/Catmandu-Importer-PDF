requires 'perl','5.10.1';
requires 'Catmandu','1.0';
requires 'namespace::clean','0.24';
#only dependency for Poppler that seems to work on Centos 7 (higher version don't)
requires 'Glib::Object::Introspection','==0.040';
requires 'Poppler','1.0101';
requires 'Moo';

on 'test', sub {
    requires 'Test::Exception','0';
    requires 'Test::More','0';
};
