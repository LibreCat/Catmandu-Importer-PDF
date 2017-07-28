use strict;
use warnings;
use utf8;
use Test::More;
use Test::Exception;
use File::Spec;

my $pkg;
BEGIN {
    $pkg = 'Catmandu::Importer::PDFInfo';
    use_ok $pkg;
}
require_ok $pkg;

my $importer;

lives_ok(sub {

    $importer = $pkg->new( file => File::Spec->catfile("t","pdf","greek.pdf") );

},"importer created");

my $array;

lives_ok(sub{

    $array = $importer->to_array();

},"imported pdf");

is_deeply($array,
[
    {
        "modification_date" =>  1501057950,
        "creator" => "Word",
        "creation_date" => 1501057950,
        "keywords" => "",
        "metadata" => undef,
        "version" => "PDF-1.3",
        "author" => undef,
        "subject" => undef,
        "producer" => "Mac OS X 10.12.6 Quartz PDFContext",
        "title" => "Microsoft Word - greek.docx"
    }
]
,"pdf read successfully");

done_testing 5;
