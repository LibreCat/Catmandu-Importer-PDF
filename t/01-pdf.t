use strict;
use warnings;
use utf8;
use Test::More;
use Test::Exception;

my $pkg;
BEGIN {
    $pkg = 'Catmandu::Importer::PDF';
    use_ok $pkg;
}

require_ok $pkg;

my $importer;

lives_ok(sub {

    $importer = Catmandu::Importer::PDF->new( file => 't/pdf/greek.pdf' );

},"importer created");

my $array;

lives_ok(sub{

    $array = $importer->to_array();
    chomp( $array->[0]->{pages}->[0]->{text} );
    #$array->[0]->{pages}->[0]->{text} =~ s/\f$//o;

},"imported pdf");

is_deeply($array,[
    {
        document            => {
            author          =>  undef,
            creation_date   =>  1501057950,
            metadata        => undef,
            creator         =>  "Word",
            keywords        =>  "",
            modification_date =>  "1501057950",
            producer        =>  "Mac OS X 10.12.6 Quartz PDFContext",
            subject         =>  undef,
            title           =>  "Microsoft Word - greek.docx",
            version         =>  "PDF-1.3",
        },
        pages               => [
            {
                height  =>  842,
                label   =>  '1',
                text    =>  "ἄνδρα μοι ἔννεπε, μοῦσα, πολύτροπον, ὃς μάλα πολλὰ",
                width   =>  595
            }
        ]
    }
],"pdf read successfully");

done_testing 5;
